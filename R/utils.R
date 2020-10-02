#' Set OpenSecrets environment variable \code{OS_KEY}
#'
#' Set OpenSecrets API Key to environment variable OS_KEY.  More information about the
#' API can be found here: https://www.opensecrets.org/resources/create/apis.php
#'
#' @param api_key OpenSecrets API Key 
#' @export
set_os_key <- function(api_key = NULL) {
  if (is.null(api_key)) stop("Please enter api_key")	
	if (!is.character(api_key)) stop("api_key must be character")
	if (identical(api_key,"")) stop("Please enter api_key")
  Sys.setenv(OS_KEY = api_key)

}


#' Retrieve environment variable \code{OS_KEY}
#'
#' Returns environment variable OS_KEY.  See set_os_key() to set. 
#'
#' @export
get_os_key <- function() {
  # taken from https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html
  pat <- Sys.getenv('OS_KEY')

  if (identical(pat, "")) {

    stop("Please set env var OS_KEY using set_os_key()",
         call. = FALSE)
  }

  pat

}


