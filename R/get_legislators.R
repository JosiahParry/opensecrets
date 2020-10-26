#'  Get Legislators
#'
#'  Provides a list of 115th Congressional legislators and associated attributes for specified subset (state or specific CID)
#'
#'  @details get_legislators() returns either a tibble with information for
#'  all legislators for a state, or a list with information about one
#'  specific legislator.  If `state` has 2 characters, the function searches
#'  for state.   If `state` has 9 characters, the function searches for
#'  specific legislator.  If `state` is neither or does not pass pattern
#'  checks, an error is returned.
#'
#'  The `res` response from GET API call is slightly different if 
#'  state or  legislator.   This requires 2 ways to convert to res
#'  into the appropriate tibble.  In particular, in case of legislator the
#'  field names include `@attributes` must be removed.
#'
#'  @param state Either (1) 2-letter state code or (2) 9-letter candidate_id
#'  (cid)
#'
#' @export
#' @examples
#' \dontrun{
#'      # Bonamici 
#'        state = "OR"
#'        candidate_id  <- "N00033474"
#'        state = candidate_id
#'        api_key = get_os_key()
#'        cycle  <- 2018
#'        get_legislators(arg=candidate_id, api_key = api_key)
#'        }
#'
get_legislators <- function(state = NULL, api_key = get_os_key()) {

  # Which type of search?
  if (nchar(state) ==2) type="state"
  if (nchar(state) ==9) type="cid"

  # set params
  id  <- state
  params <- list(id = id,
                 apikey = api_key,
                 output = "json")
  # send query
  res <- GET("https://www.opensecrets.org/api/?method=getLegislators",
             query = params,
             user_agent("httr")) %>%
		httr::stop_for_status() %>% 
    content("text") %>%
    jsonlite::fromJSON(flatten = TRUE)

# process response
  # NOTE:
  # "state" returns dataframe
  # "cid"   returns list
  #
  if (type == "state"){
    ret <- purrr::pluck(res, "response", "legislator") %>% 
    dplyr::rename_all(str_remove, "@attributes.") %>%
    janitor::clean_names() %>%
    as_tibble()
  }

  # here pluck returns list, @attributes just another level
  if (type == "cid") {
    ret  <- purrr::pluck(res, "response", "legislator", "@attributes") %>% 
      as_tibble()
  }

    return (ret)
}


