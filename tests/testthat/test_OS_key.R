context("test api key")

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})



test_that("set_api_key()", {
						expect_error(set_os_key())
#						expect_false(set_os_key(""))
						expect_true(set_os_key(Sys.getenv("API_KEY")))
})

# Add:   GET and check status code
test_that("get_os_key()", {
						expect_true(is.character(Sys.getenv("API_KEY")	))
						expect_false(identical(Sys.getenv("API_KEY"),""))
})

