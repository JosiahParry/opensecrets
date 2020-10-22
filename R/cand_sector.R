#' Candidate contributions by sector
#'
#' Provides sector total of specified politician's receipt
#'
#' @param candidate_id candidate ID
#' @param cycle 2012, 2014, 2016, 2018; leave blank for latest cycle
#'
#'
#
# REMOVE
# ' @importFrom httr GET user_agent content
# ' @importFrom tibble as_tibble
# ' @importFrom magrittr %>%
# ' @importFrom purrr pluck
# ' @importFrom dplyr mutate select
# ' @importFrom jsonlite fromJSON
#
#' @export
cand_sector <- function(candidate_id, cycle = 2018, api_key = get_os_key()) {

  params <- list(cid = candidate_id,
                 output = "json",
                 cycle = cycle,
                 apikey = api_key)

  res <- httr::GET("http://www.opensecrets.org/api/?method=candSector",
             query = params,
             httr::user_agent("httr")) %>%
		httr::stop_for_status() %>% 
    httr::content("text") %>%
    jsonlite::fromJSON()
# NEXT
  process_cand_sector(res)


  # REMOVE
  # res%>%
  #   pluck("response", "sectors", "sector", "@attributes") %>%
  #   mutate(candidate = cand_name,
  #          party = cand_party,
  #          cycle = res$response$sectors$`@attributes`$cycle,
  #          cid = res$response$sectors$`@attributes`$cid)%>%
  #   select(candidate, party, cycle, everything()) %>%
  #   as_tibble()

}

#' @title process_cand_sector
#' @description process res that returned from API CALL
#'
#'
#'
#'
  process_cand_sector  <- function(res = NULL){

# pluck(res, "response", "sectors", "@attribute") returns list of candid info
# pluck(res, "response", "sectors", "sector", "@attributes") returns tibble of
    # money.
    #
# Candidate info is a LIST    
    #
  l  <- res %>% pluck("response", "sectors", "@attributes")

  res%>%
    pluck("response", "sectors", "sector", "@attributes") %>%
    mutate(candidate = l[["cand_name"]],
           party = NA , # extract,
           cycle = l[["cycle"]],
           cid = l[["cid"]]

           # REMOVE
           # cycle = res$response$sectors$`@attributes`$cycle,
           # cid = res$response$sectors$`@attributes`$cid)%>%
           ) %>% 
    select(candidate, party, cycle, everything()) %>%
    as_tibble()
  }

