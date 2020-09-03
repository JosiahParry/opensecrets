#' Top contributor to specific candidate
#'
#' Returns top contributors to specified candidate for a House or Senate seat or member of Congress. These are 6-year numbers for senators/Senate candidates; 2-year numbers for representatives/House candidates.
#'
#' @param candidate_id Candidate ID
#' @param cycle 2012, 2014, 2016, 2018 (blank or out of range cycle will return most recent cycle)
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom stringr str_remove str_extract str_remove_all
#' @importFrom dplyr mutate select rename_all
#' @importFrom magrittr %>%
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom jsonlite fromJSON
#' @export
cand_contrib <- function(candidate_id = NULL, cycle = 2018, api_key = get_os_key()) {

  params <- list(cid = candidate_id,
                 cycle = cycle,
                 apikey = api_key,
                 output = "json")

  res <- GET("https://www.opensecrets.org/api/?method=candContrib",
             query = params,
             user_agent("httr")) %>%
		httr::stop_for_status() %>% 
    content("text") %>%
    jsonlite::fromJSON()


  raw_cand <- res$response$contributors$`@attributes`$cand_name

  cand_name <- str_remove(raw_cand, " \\([A-Z0-9]+\\)")

  cand_party <- str_extract(raw_cand, "\\([A-Z0-9]+\\)") %>%
    str_remove_all(c("\\(|\\)"))

  res[["response"]][["contributors"]][["contributor"]][[1]] %>%
    janitor::clean_names() %>%
    rename_all(str_remove, pattern = "attributes") %>%
    as_tibble() %>%
    mutate(candidate = cand_name,
           party = cand_party,
           cycle = res$response$contributors$`@attributes`$cycle,
           cid = res$response$contributors$`@attributes`$cid)%>%
    select(candidate, party, cycle, org_name, everything())

}
