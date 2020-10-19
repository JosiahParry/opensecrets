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

  res%>%
    pluck("response", "sectors", "sector", "@attributes") %>%
    mutate(candidate = cand_name,
           party = cand_party,
           cycle = res$response$sectors$`@attributes`$cycle,
           cid = res$response$sectors$`@attributes`$cid)%>%
    select(candidate, party, cycle, everything()) %>%
    as_tibble()

}


# ====================================
# proposed
# ====================================
#
#' get_sector2 Candidate contributions by sector
#'
#' Provides sector total of specified politician's receipt
#'
#' @param candidate_id candidate ID
#' @param cycle 2012, 2014, 2016, 2018; leave blank for latest cycle
#
#' @export
cand_sector2 <- function(candidate_id, cycle = 2018, api_key = get_os_key()) {


# PROPOSE 1:  new function to assemble params
params <- list(cid = candidate_id,
               output = "json",
               cycle = cycle,
               apikey = api_key)

# PROPOSE 2: new function for call
res <- httr::GET("http://www.opensecrets.org/api/?method=candSector",
             query = params,
             httr::user_agent("httr")) %>%
		httr::stop_for_status() %>% 
    httr::content("text") %>%
    jsonlite::fromJSON()

# PROPOSE 3:  new function for post-processing
stopifnot(!rlang::is_null(cand_name),
          !rlang::is_null(party))
# his way
z  <- res %>% pluck("response", "sectors", "sector", "@attributes") %>% 
  as_tibble()
# same, there is no cand_name or cand_party
z  <- res %>% pluck("response", "sectors", "sector") %>% as_tibble()

z %>% 
    dplyr::mutate(
									candidate = cand_name,
           				party = cand_party,
           				cycle = cycle,
           				cid = candidate_id) %>%
    dplyr::select(candidate, party, cycle, everything()) 
}


