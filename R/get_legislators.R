#'  @title Get Legislators
#'
#'  @description
#'
#'  Provides a list of 115th Congressional legislators and associated attributes for specified subset (state or specific CID)
#'
#'  @details get_legislators() returns tibble with information for either all
#'  legislators for a state, or information about one specific legislator.  If
#'  `arg` has 2 characters, the function searches for state.   If `arg` has 9
#'  characters, the function searches for specific legislator.  If `arg` is
#'  neither or does not pass pattern checks, an error is returned.
#'
#'  TODO:   try json(simplifyDataFrame=TRUE)
#'  The `res` response from GET API call is slightly different if `arg` is
#'  state or if `arg` is a legislator.   This requires 2 ways to convert to res
#'  into the appropriate tibble.  In particular, in case of legislator the
#'  field names include `@attributes` that must be removed.
#'  @param arg Either (1) 2-letter state code or (2) 9-letter candidate_id
#'  (cid)
#'
#' @export
#' @example
#' \dontrun{
#'      # Bonamici 
#'        state = "OR"
#'        candidate_id  <- "N00033474"
#'        arg = candidate_id
#'        api_key = get_os_key()
#'        cycle  <- 2018
#'        get_legislators(arg=candidate_id, api_key = api_key)
#'        }
#'
#' # REMOVE
#' @importFrom httr GET user_agent content
#' @importFrom tibble as_tibble
#' @importFrom dplyr rename_all
#' @importFrom janitor clean_names
#' @importFrom magrittr %>%
#' @importFrom stringr str_remove
#' @importFrom jsonlite fromJSON
get_legislators <- function(arg = NULL, api_key = get_os_key()) {

  # ========================
  ## TO DO:   arg checks
  ## base::match.arg(arg, choices=)  does not seem to support pattern matching.
  ##

  # is arg NULL?
  # is arg character?
  # is arg length 2  ?  check again States [must find!]  and proceed,  OR error.
  # is arg length 9 [improve this] ?  assume OK (?) and proceed.
  #
  # ========================

  # Which type of search?
  if (nchar(arg) ==2) type="state"
  if (nchar(arg) ==9) type="cid"

  # set params
  id  <- arg
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

  # "state" returns dataframe
  # "cid"   returns list
  process_legislators(res = res, type=type)

# To Remove
  # res[[1]][[1]] %>%
  #   dplyr::rename_all(str_remove, "@attributes.") %>%
  #   janitor::clean_names() %>%
  #   as_tibble()
  #
}


#'  @title process_legislators
#'
#'  @description helper function to handle response (from API call)
#'
#'  @details  NOT exported
#'  @param res response from API call
#'  @param type Type of information `state` or `legislator` to be processed.
#'
process_legislators  <- function(res = NULL, type=NULL) {

  if (type == "state"){
    ret <- purrr::pluck(res, "response", "legislator") %>% 
    dplyr::rename_all(str_remove, "@attributes.") %>%
    janitor::clean_names() %>%
    as_tibble()
  }

  # pluck returns list, @attributes just another level
  if (type == "cid") {
    ret  <- pluck(res, "response", "legislator", "@attributes") %>% 
      as_tibble()
  }

    return (ret)
  
}


