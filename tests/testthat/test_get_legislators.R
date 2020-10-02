context("test get_legislators()")
library(tibble)



SKIP_previously_tested  <- FALSE	  
SKIP_slow  <- FALSE		 

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
})

# Add?   GET and check status code


test_that("always succeed", succeed())
test_that("always fail", {
						expect_error(fail())
})

