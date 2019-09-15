#' Candidate contributions by sector
#'
#' Provides sector total of specified politician's receipt
#'
#' @param candidate_id candidate ID
#' @param cycle 2012, 2014, 2016; leave blank for latest cycle
#'
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#' @importFrom purrr pluck
#' @importFrom dplyr mutate select
#' @importFrom jsonlite fromJSON
#' @export
cand_sector <- function(candidate_id, cycle = 2018, api_key = get_os_key()) {

  params <- list(cid = candidate_id,
                 output = "json",
                 cycle = 2018,
                 apikey = api_key)

  res <- GET("http://www.opensecrets.org/api/?method=candSector",
             query = params,
             user_agent("httr")) %>%
    content("text") %>%
    jsonlite::fromJSON()

  res%>%
    pluck("response", "sectors", "sector", "@attributes") %>%
    mutate(candidate = cand_name,
           party = cand_party,
           cycle = res$response$sectors$`@attributes`$cycle,
           cid = res$response$sectors$`@attributes`$cid)%>%
    select(candidate, party, cycle, everything()) %>%
    as_tibble()

}
