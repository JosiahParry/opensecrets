context("test get_legislators()")

after_restart  <- function() {
  # setup (after restart R)
  load_all()
  set_os_key(Sys.getenv("API_KEY"))
  api_key  <- get_os_key()

  # misc sample 
    # Bonamici 
    state = "OR"
    candidate_id  <- "N00033474"
    arg = candidate_id
    cycle  <- 2018
}
if (FALSE ) {
  after_restart()
}


# need these to work
# cand_name  <- "Bonamici" 
# cand_party  <- "D"
#
get_legislators(arg=arg, get_os_key())
SKIP_previously_tested  <- FALSE	  
SKIP_slow  <- FALSE		 

test_that("state example",{
            arg = "OR"
						t  <- get_legislators(arg=arg, get_os_key() )
						t
})

test_that("cid example",{
            arg  <- "N00033474"
						t  <- get_legislators(arg=arg, get_os_key() )
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

