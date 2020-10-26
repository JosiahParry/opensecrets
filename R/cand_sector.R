#' Candidate contributions by sector
#'
#' Provides sector total of specified politician's receipt
#'
#' @param candidate_id candidate ID
#' @param cycle 2012, 2014, 2016, 2018; leave blank for latest cycle
#'
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

# process res
  #
# NOTE:
# pluck(res, "response", "sectors", "@attribute") returns list of candid info
# pluck(res, "response", "sectors", "sector", "@attributes") returns tibble of
    # money.
    
# candidate_info is a LIST    
  candidate_info  <- res %>% pluck("response", "sectors", "@attributes")

# Extract party from "cand_name" in 2 steps
  res%>%
    pluck("response", "sectors", "sector", "@attributes") %>%
    mutate(candidate = candidate_info[["cand_name"]],
           party = stringr::str_extract( 
              stringr::str_extract( candidate_info[["cand_name"]], "\\(.\\)"), 
             "[:upper:]"),

           cycle = candidate_info[["cycle"]],
           cid = candidate_info[["cid"]]
           ) %>% 
    select(candidate, party, cycle, everything()) %>%
    as_tibble()
  }



