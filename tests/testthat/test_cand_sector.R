context("test cand_sector()")
library(tibble)

after_restart  <- function() {
  # setup (after restart R)
  load_all()
  set_os_key(Sys.getenv("API_KEY"))
  api_key  <- get_os_key()
}
if (FALSE ) {
  after_restart()
}



# Bonamici 
candidate_id  <- "N00033474"
cycle  <- 2018

# need these to work
# cand_name  <- "Bonamici" 
# cand_party  <- "D"

# as written
#cand_sector(candidate_id=candidate_id, cycle=cycle, api=get_os_key())


# proposed
#cand_sector2(candidate_id=candidate_id, cycle=cycle, api=get_os_key())

test_that("cand_sector, as written; missing 2 variables",{
            expect_error(cand_sector(candidate_id=candidate_id,
                                     cycle=cycle,
                                     api = get_os_key())
            )

})


# FAILS (missing variables)
test_that(" experiment w/o expectation", {
            cand_sector(candidate_id=candidate_id,
                                     cycle=cycle,
                                     api = get_os_key())
            
})

# FAILS
# Should NOT fail;  needed variabls are in calling envonment.
# How does test_that work?
            cand_name  <- "Bonamici" 
            cand_party  <- "D"
test_that("cand_sector, as written, including 2 variables",{
            # cand_name  <- "Bonamici" 
            # cand_party  <- "D"
            skip("skip test WITH variables added")
            expect_silent(cand_sector(candidate_id=candidate_id,
                                     cycle=cycle,
                                     api = get_os_key())
            )



})

