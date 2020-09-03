#' Candidate contributions by specified industry
#'
#' Provides total contributed to specified candidate from specified industry. Senate data reflects 2-year totals.
#'
#' @param candidate_id Candidate ID
#' @param industry_id a 3-character industry code
#' @param cycle 	2012, 2014, 2016, 2018 (blank or out of range cycle will return most recent cycle)
#'
#' #' @examples
#'
#'\dontrun{
#' # jeff sessions contributions from real estate
#' cand_ind_contrib("N00003062", "F10", 2018)
#'}
#'
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble tibble
#' @importFrom magrittr %>%
#' @importFrom purrr pluck
#' @importFrom tidyr pivot_wider
#' @importFrom jsonlite fromJSON
#' @export
cand_ind_contrib <- function(candidate_id, industry_id, cycle = 2018, api_key = get_os_key()) {

  params <- list(cid = candidate_id,
                 ind = industry_id,
                 output = "json",
                 cycle = 2018,
                 apikey = api_key)

  GET("https://www.opensecrets.org/api/?method=candIndByInd",
      query = params,
      user_agent("httr")) %>%
    content("text") %>%
    jsonlite::fromJSON() %>%
    pluck("response", "candIndus", "@attributes") %>%
    unlist() %>%
    tibble(cols = names(.),
           values = .) %>%
    pivot_wider(names_from = cols, values_from = values)


}
