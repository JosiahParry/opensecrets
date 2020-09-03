#' Candidate Summary
#' Provides summary fundraising information for specified politician
#'
#' @param candidate_id CandidateID
#' @param cycle 2012, 2014, 2016, 2018; leave blank for latest cycle
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate select
#' @importFrom jsonlite fromJSON
#' @export
cand_summary <- function(candidate_id = NULL, cycle = NULL,
                         api_key = get_os_key()) {

  params <- list(cid = candidate_id,
                 cycle = cycle,
                 apikey = api_key,
                 output = "json")

  res <- GET("https://www.opensecrets.org/api/?method=candContrib",
             query = params,
             user_agent("httr")) %>%
    content("text") %>%
    jsonlite::fromJSON()

  raw_cand <- res$response$contributors$`@attributes`$cand_name

  cand_name <- str_remove(raw_cand, " \\([A-Z0-9]+\\)")
  cand_party <- str_extract(raw_cand, "\\([A-Z0-9]+\\)") %>%
    str_remove_all(c("\\(|\\)"))

  res %>%
    pluck("response", "contributors", "contributor", "@attributes") %>%
    mutate(candidate = cand_name,
           party = cand_party,
           cycle = pluck("response", "contributors", "@attributes", "cycle")) %>%
    as_tibble()


}
