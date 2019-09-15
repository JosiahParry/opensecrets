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
    content("text") %>%
    jsonlite::fromJSON()

  res %>%
    pluck("response", "industries", "industry", "@attributes") %>%
    mutate(candidate = cand_name,
           party = cand_party,
           cycle = res$response$industries$`@attributes`$cycle,
           cid = res$response$industries$`@attributes`$cid)%>%
    select(candidate, party, cycle, everything()) %>%
    as_tibble()

}
