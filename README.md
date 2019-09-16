
<!-- README.md is generated from README.Rmd. Please edit that file -->

# opensecrets

<!-- badges: start -->

<!-- badges: end -->

The goal of opensecrets is to create a reimagining of the OpenSecrets
API. The package is intended to follow almost verbatim with the [API
documentation](https://www.opensecrets.org/open-data/api-documentation).
Refer to the documentation for more information of the data that is
retrieved.

## Installation

You can install the released version of opensecrets from
[GitHub](https://github.com/josiahparry/opensecrets) with:

``` r
remotes::install_github("josiahparry/opensecrets")
```

This package is in very experimental phases and is subject to breaking.
There is much to do, but a this serves as a minimal viable product.

Please submit issues and feature requests as you come about them.

## API Key

Register with OpenSecrets and register for an API key at [this
link](https://www.opensecrets.org/api/admin).

Set your key using `set_os_key("my_key_here")` or store it in
`.Renviron`

## Examples

List all available legislators for a given state.

``` r
library(opensecrets)

ca_legislators <- get_legislators("CA")
ca_legislators
#> # A tibble: 56 x 21
#>    cid   firstlast lastname party office gender first_elected exit_code
#>    <chr> <chr>     <chr>    <chr> <chr>  <chr>  <chr>         <chr>    
#>  1 N000… Doug LaM… LAMALFA  R     CA01   M      2012          0        
#>  2 N000… Jared Hu… HUFFMAN  D     CA02   M      2012          0        
#>  3 N000… John Gar… GARAMEN… D     CA03   M      2009          0        
#>  4 N000… Tom McCl… MCCLINT… R     CA04   M      2008          0        
#>  5 N000… Mike Tho… THOMPSON D     CA05   M      1998          0        
#>  6 N000… Doris O … MATSUI   D     CA06   F      2005          0        
#>  7 N000… Ami Bera  BERA     D     CA07   M      2012          0        
#>  8 N000… Paul Cook COOK     R     CA08   M      2012          0        
#>  9 N000… Jerry Mc… MCNERNY  D     CA09   M      2006          0        
#> 10 N000… Jeff Den… DENHAM   R     CA10   M      2010          21       
#> # … with 46 more rows, and 13 more variables: comments <chr>, phone <chr>,
#> #   fax <chr>, website <chr>, webform <chr>, congress_office <chr>,
#> #   bioguide_id <chr>, votesmart_id <chr>, feccandid <chr>,
#> #   twitter_id <chr>, youtube_url <chr>, facebook_id <chr>,
#> #   birthdate <chr>
```

Get personal finance information for a given legislator.

``` r
library(tidyverse)

# get Nancy Pelosi
ca_legislators %>% 
  filter(firstlast == "Nancy Pelosi") %>% 
  pull(cid) %>% 
  personal_finance()
#> # A tibble: 1 x 18
#>   name  data_year member_id net_low net_high positions_held_… asset_count
#>   <chr> <chr>     <chr>     <chr>   <chr>    <chr>            <chr>      
#> 1 Pelo… 2016      N00007360 -21225… 1380509… 0                44         
#> # … with 11 more variables: asset_low <chr>, asset_high <chr>,
#> #   transaction_count <chr>, tx_low <chr>, tx_high <chr>, source <chr>,
#> #   origin <chr>, update_timestamp <chr>, positions <list>, assets <list>,
#> #   transactions <list>
```

Use `purrr::map()` to iterate over multiple individuals.

``` r
ca_legislators %>% 
  # take only 3 legislators
  slice(1:3) %>% 
  mutate(pf = map(cid, personal_finance)) %>% 
  unnest()
#> # A tibble: 3 x 39
#>   cid   firstlast lastname party office gender first_elected exit_code
#>   <chr> <chr>     <chr>    <chr> <chr>  <chr>  <chr>         <chr>    
#> 1 N000… Doug LaM… LAMALFA  R     CA01   M      2012          0        
#> 2 N000… Jared Hu… HUFFMAN  D     CA02   M      2012          0        
#> 3 N000… John Gar… GARAMEN… D     CA03   M      2009          0        
#> # … with 31 more variables: comments <chr>, phone <chr>, fax <chr>,
#> #   website <chr>, webform <chr>, congress_office <chr>,
#> #   bioguide_id <chr>, votesmart_id <chr>, feccandid <chr>,
#> #   twitter_id <chr>, youtube_url <chr>, facebook_id <chr>,
#> #   birthdate <chr>, name <chr>, data_year <chr>, member_id <chr>,
#> #   net_low <chr>, net_high <chr>, positions_held_count <chr>,
#> #   asset_count <chr>, asset_low <chr>, asset_high <chr>,
#> #   transaction_count <chr>, tx_low <chr>, tx_high <chr>, source <chr>,
#> #   origin <chr>, update_timestamp <chr>, positions <list>, assets <list>,
#> #   transactions <list>
```

## Reference Tables

``` r
opensecrets::legislators
#> # A tibble: 555 x 22
#>    cid   firstlast lastname state party office gender first_elected
#>    <chr> <chr>     <chr>    <chr> <chr> <chr>  <chr>  <chr>        
#>  1 N000… Bradley … BYRNE    AL    R     AL01   M      2013         
#>  2 N000… Martha R… ROBY     AL    R     AL02   F      2010         
#>  3 N000… Mike D R… ROGERS   AL    R     AL03   M      2002         
#>  4 N000… Robert B… ADERHOLT AL    R     AL04   M      1996         
#>  5 N000… Mo Brooks BROOKS   AL    R     AL05   M      2010         
#>  6 N000… Gary Pal… PALMER   AL    R     AL06   M      2014         
#>  7 N000… Terri A … SEWELL   AL    D     AL07   F      2010         
#>  8 N000… Jeff Ses… SESSIONS AL    R     ALS1   M      1996         
#>  9 N000… Doug Jon… JONES    AL    D     ALS1   M      2017         
#> 10 N000… Luther S… Strange  AL    R     ALS1   M      2017         
#> # … with 545 more rows, and 14 more variables: exit_code <chr>,
#> #   comments <chr>, phone <chr>, fax <chr>, website <chr>, webform <chr>,
#> #   congress_office <chr>, bioguide_id <chr>, votesmart_id <chr>,
#> #   feccandid <chr>, twitter_id <chr>, youtube_url <chr>,
#> #   facebook_id <chr>, birthdate <chr>
```

``` r
opensecrets::categories
#> # A tibble: 459 x 6
#>    catcode catname            catorder industry         sector  sector_long
#>    <chr>   <chr>              <chr>    <chr>            <chr>   <chr>      
#>  1 A0000   Agriculture        A11      Misc Agriculture Agribu… Agribusine…
#>  2 A1000   Crop production &… A01      Crop Production… Agribu… Agribusine…
#>  3 A1100   Cotton             A01      Crop Production… Agribu… Agribusine…
#>  4 A1200   Sugar cane & suga… A01      Crop Production… Agribu… Agribusine…
#>  5 A1300   Tobacco & Tobacco… A02      Tobacco          Agribu… Agribusine…
#>  6 A1400   Vegetables, fruit… A01      Crop Production… Agribu… Agribusine…
#>  7 A1500   Wheat, corn, soyb… A01      Crop Production… Agribu… Agribusine…
#>  8 A1600   Other commodities… A01      Crop Production… Agribu… Agribusine…
#>  9 A2000   Milk & dairy prod… A04      Dairy            Agribu… Agribusine…
#> 10 A2300   Poultry & eggs     A05      Poultry & Eggs   Agribu… Agribusine…
#> # … with 449 more rows
```
