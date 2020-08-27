#' Member Personal Finance Data
#'
#' Returns data on the personal finances of a member of Congress, as well as judicial and executive branches
#'
#' @param api_key Your OpenSecrets API Key
#' @param candidate_id candidate ID
#' @param year 2013, 2014, 2015 and 2016 data provided where available
#'
#' @importFrom magrittr %>%
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom purrr pluck
#' @importFrom dplyr mutate select
#' @importFrom jsonlite fromJSON
#' @export
personal_finance <- function(candidate_id, year = 2016, api_key = get_os_key()) {


  params <- list(apikey = api_key,
                 cid = candidate_id,
                 year = year,
                 output = "json")

  # sent query
  res <- GET("https://www.opensecrets.org/api/?method=memPFDprofile",
             query = params,
             user_agent("httr")) %>%
		httr::stop_for_status() %>% 
    content("text") %>%
    jsonlite::fromJSON()


  positions <- pluck(res, "response", "member_profile", "positions", "position", "@attributes")

  assets <- pluck(res, "response", "member_profile", "assets", "asset", "@attributes")

  transactions <- pluck(res, "response", "member_profile",
                        "transactions", "transaction", "@attributes")

  pluck(res, "response", "member_profile", "@attributes") %>%
    as_tibble() %>%
    mutate(positions = list(positions),
           assets = list(assets),
           transactions = list(transactions))

}
