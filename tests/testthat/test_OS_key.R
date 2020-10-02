context("test api key")


# SAVE valid OS_KEY, before testing!
valid_os_key  <- Sys.getenv("OS_KEY")

test_that("set_api_key()", {

						expect_error(set_os_key())

						expect_error(set_os_key(xyz))

						test_key  <- ""
						expect_error(set_os_key(test_key))

						test_key  <- NULL
						expect_error(set_os_key(test_key))

						test_key  <- "random value"
						set_os_key(test_key)
						expect_equal(test_key, get_os_key())


})

# QUESTION:   Check GET with valid \code{OS_KEY} returns status 200? 
test_that("get_os_key()", {
						test_key  <- "random value"
						set_os_key(test_key)

						expect_equal(test_key, get_os_key())

})

# RESTORE valid OS_KEY
set_os_key(valid_os_key)
