#' Organization Sumamry
#'
#' Provides 2018 summary fundraising information for the specified organization id
#' @param api_key Your OpenSecrets API Key
#' @param org_id:	(required) CRP orgid (available via getOrgID method)
#'
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#' @importFrom purrr pluck
#' @importFrom dplyr mutate select
#' @importFrom jsonlite fromJSON
#' @export
org_summary <- function(org_id, api_key = get_os_key()) {


  params <- list(id = org_id,
                 apikey = api_key,
                 output = "json")

  # sent query
  res <- GET("https://www.opensecrets.org/api/?method=orgSummary",
             query = params,
             user_agent("httr")) %>%
    content("text") %>%
		httr::stop_for_status() %>% 
    jsonlite::fromJSON()

  pluck(res, "response", "organization", "@attributes") %>%
    as_tibble()


}
