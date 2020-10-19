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
  ## TO DO:   arg checks
  ##
  # First check on function args
  #   if (is.null(cid) && is.null(state)) 
  #     stop("Please provide CID or State")
  # 
  # 
  #   if (!is.null(cid) && !is.null(state)) 
  #     stop("Please provide only one, CID or State")
  # 
  #   if (is.null(cid)) id=state else id=cid

  # REDO: MORE args check
  #   stopifnot(!is.null(state),
  #             is.character(state),
  #             length(state) ==1)
  # 
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

  process_legislators(res = res)

# To Remove
  # res[[1]][[1]] %>%
  #   rename_all(str_remove, "@attributes.") %>%
  #   janitor::clean_names() %>%
  #   as_tibble()
}

#' @title get_legislator
#'
#'
#'
#'
#'
#'
get_legislator <- function(cid = NULL, api_key = get_os_key()) {

  ## TO DO:   check args
  id <- cid
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
  l  <- list( 
    party= pluck(res, "response", "legislator", "@attributes", "party"),
    lastname=pluck(res, "response", "legislator", "@attributes", "lastname")
  )
}

#'  @title process_legislators
#'
#'  @description helper function to handle response (from API call)
#'
#'  @details  NOT exported
#'  @param res response from API call
#'
process_legislators  <- function(res = NULL) {
  res[[1]][[1]] %>%
    rename_all(str_remove, "@attributes.") %>%
    janitor::clean_names() %>%
    as_tibble()
}


