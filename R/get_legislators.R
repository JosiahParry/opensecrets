#' Get Legislators
#'
#' Provides a list of 115th Congressional legislators and associated attributes for specified subset (state or specific CID)
#'
#' @export
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom dplyr rename_all
#' @importFrom janitor clean_names
#' @importFrom magrittr %>%
#' @importFrom stringr str_remove
#' @importFrom jsonlite fromJSON
get_legislators <- function(state = NULL, api_key = get_os_key()) {
  params <- list(id = state,
                 apikey = api_key,
                 output = "json")

  # sent query
  res <- GET("https://www.opensecrets.org/api/?method=getLegislators",
             query = params,
             user_agent("httr")) %>%
    content("text") %>%
    jsonlite::fromJSON(flatten = TRUE)

  res[[1]][[1]] %>%
    rename_all(str_remove, "@attributes.") %>%
    janitor::clean_names() %>%
    as_tibble()
}
