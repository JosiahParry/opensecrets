#' Independent Expenditures
#'
#' Method to access the latest 50 independent expenditure transactions reported. Updated 4 times a day.
#' @param api_key Your OpenSecrets API Key
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate select
#' @importFrom jsonlite fromJSON
#' @export
independent_expend <- function(api_key = get_os_key()) {

  params <- list(apikey = api_key,
                 output = "json")

  # sent query
  res <- GET("http://www.opensecrets.org/api/?method=independentExpend",
             query = params,
             user_agent("httr")) %>%
		httr::stop_for_status() %>% 
    content("text") %>%
    jsonlite::fromJSON()

  res %>%
    pluck("response", "indexp", "@attributes") %>%
    as_tibble()

}
