#' Congressional committee donations by industry
#'
#' Provides summary fundraising information for a specific committee, industry and congress number
#'
#' @param committee_id Committee ID in CQ format
#' @param industry_id 112 (uses 2012 data), 113 (uses 2014 data), 114 (uses 2016 data), or 115 (uses 2018 data); leave blank for latest congress
#' @param session 112 (uses 2012 data), 113 (uses 2014 data), 114 (uses 2016 data), or 115 (uses 2018 data); leave blank for latest congress
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @importFrom jsonlite fromJSON
#' @export
committee_ind  <- function(committee_id, industry_id, session = 115, api_key = get_os_key()) {

  params <- list(cmte = committee_id,
                 output = "json",
                 congno = session,
                 indus = industry_id,
                 apikey = api_key)

  res <- GET("https://www.opensecrets.org/api/?method=congCmteIndus",
             query = params,
             user_agent("httr")) %>%
    content("text") %>%
    jsonlite::fromJSON()

  res %>%
    pluck("response", "committee", "member", "@attributes") %>%
    mutate(committee = pluck("response", "committee", "@attributes", "committee"),
           industry = pluck("response", "committee", "@attributes", "industry"),
           session = pluck("response", "committee", "@attributes", "congno")) %>%
    as_tibble()

}
