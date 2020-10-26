context("test get_legislators()")
library(tibble)
# ================================
# EASIER, using jsonlite?

apikey  <- Sys.getenv("API_KEY")
nj  <- jsonlite::fromJSON( 
paste0("http://www.opensecrets.org/api/?method=getLegislators&id=NJ&apikey=", 
       apikey, "&output=json"))
nj

# best choice
t  <- tibble::as_tibble(purrr::pluck(nj, "response", "legislator",
                                     "@attributes"))
t # 14 x 21
# ================================


after_restart  <- function() {
  # setup (after restart R)
  load_all()
  set_os_key(Sys.getenv("API_KEY"))
  api_key  <- get_os_key()

}
if (FALSE ) {
  after_restart()
  # misc sample 
    # Bonamici 
    state = "OR"
    candidate_id  <- "N00033474"
    state = "OR"
    cycle  <- 2018
}


#get_legislators(state=state, get_os_key())
SKIP_previously_tested  <- FALSE	  
SKIP_slow  <- FALSE		 

test_that("state example",{
						t  <- get_legislators("OR", get_os_key() )
						t
})

test_that("cid example",{
            state  <- "N00033474"
						t  <- get_legislators(state=state, get_os_key() )
            t
})
test_that("state", {
						expect_error(get_legislators("",get_os_key() ))
						expect_error(get_legislators(NULL,get_os_key() ))
						expect_error(get_legislators("XYZ",get_os_key() ))
						expect_error(get_legislators("XY",get_os_key() ))
})

test_that("tibble", {
						skip_if(SKIP_slow, "too slow")
						state  <- "OR"

						expect_true(is_tibble(get_legislators(state, get_os_key())))
						expect_true(is_tibble(get_legislators("ND", get_os_key())))

						expect_equal(nrow(get_legislators(state, get_os_key())), 7)
						expect_equal(nrow(get_legislators("OR", get_os_key())), 7)
						expect_equal(nrow(get_legislators("ND", get_os_key())), 3)

            candidate_id  <- "N00033474"
						expect_true(is_tibble(get_legislators(candidate_id, get_os_key())))
						expect_true(is_tibble(get_legislators("N00033474", get_os_key())))
})

# Add?   GET and check status code


test_that("always succeed", succeed())
test_that("always fail", {
						expect_error(fail())
})

