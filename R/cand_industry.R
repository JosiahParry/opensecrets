#' Candidate Industry Contributions
#'
#' Provides the top ten industries contributing to a specified candidate for a House or Senate seat or member of Congress. These are 6-year numbers for Senators/Senate candidates; 2-year total for Representatives/House candidates.
#'
#' @param candidate_id Candidate ID
#' @param cycle 2012, 2014, 2016, 2018 (blank or out of range cycle will return most recent cycle)
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#' @importFrom purrr pluck
#' @importFrom dplyr mutate select
#' @importFrom jsonlite fromJSON
#' @export
cand_industry <- function(candidate_id, cycle = 2018, api_key = get_os_key()) {

  params <- list(cid = candidate_id,
                 output = "json",
                 cycle = 2018,
                 apikey = api_key)

  res <- GET("https://www.opensecrets.org/api/?method=candIndustry",
             query = params,
             user_agent("httr")) %>%
		httr::stop_for_status() %>% 	
    content("text") %>%
    jsonlite::fromJSON()

  raw_cand <- res$response$industries$`@attributes`$cand_name

  cand_name <- str_remove(raw_cand, " \\([A-Z0-9]+\\)")
  cand_party <- str_extract(raw_cand, "\\([A-Z0-9]+\\)") %>%
    str_remove_all(c("\\(|\\)"))

  res %>%
    pluck("response", "industries", "industry", "@attributes") %>%
    mutate(candidate = cand_name,
           party = cand_party,
           cycle = res$response$industries$`@attributes`$cycle,
           cid = res$response$industries$`@attributes`$cid)%>%
    select(candidate, party, cycle, everything()) %>%
    as_tibble()

}


