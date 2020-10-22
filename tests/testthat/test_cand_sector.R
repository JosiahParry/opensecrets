context("test cand_sector()")
library(tibble)

after_restart  <- function() {
  # setup (after restart R)
  load_all()
  set_os_key(Sys.getenv("API_KEY"))
  api_key  <- get_os_key()
  # sample data
  # Bonamici 
  candidate_id  <- "N00033474"
  cycle  <- 2018
}
if (FALSE ) {
  after_restart()
}


test_that("cand_sector", {
  cand_sector(candidate_id=candidate_id, cycle=cycle, api=get_os_key())
  expect_silent(cand_sector(candidate_id=candidate_id,
                                     cycle=cycle,
                                     api = get_os_key())
            )
})




