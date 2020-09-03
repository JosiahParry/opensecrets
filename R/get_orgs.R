#' Get Organizations
#'
#' Get Organization ID from partial name or partial name of organization requested
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom purrr pluck
#' @importFrom dplyr mutate select
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>%
#' @export
get_orgs <- function(organization = NULL, api_key = get_os_key()) {

  params <- list(org = organization,
                 apikey = api_key,
                 output = "json")

  # sent query
  res <- GET("https://www.opensecrets.org/api/?method=getOrgs",
             query = params,
             user_agent("httr")) %>%
    content("text") %>%
    jsonlite::fromJSON()

  pluck(res, "response", "organization", "@attributes") %>%
    as_tibble()


}
