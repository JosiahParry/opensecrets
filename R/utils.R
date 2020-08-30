
#' @export
set_os_key <- function(api_key) {

  Sys.setenv(OS_KEY = api_key)

}


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


