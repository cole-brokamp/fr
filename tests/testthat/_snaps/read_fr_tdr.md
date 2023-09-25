# read_fr_tdr works

    Code
      read_tdr_csv(x = test_path("hamilton_poverty_2020",
        "tabular-data-resource.yaml"))
    Message <cliMessage>
      ── hamilton_poverty_2020 ──
      • version: 0.0.1
      • title: Hamilton County Poverty Rates in 2020
    Output
      # A tibble: 226 x 3
         census_tract_id_2020  year fraction_poverty
         <chr>                <dbl>            <dbl>
       1 39061021508           2020            0.057
       2 39061021421           2020            0.031
       3 39061023300           2020            0.03 
       4 39061002000           2020            0.098
       5 39061002500           2020            0.442
       6 39061007700           2020            0.603
       7 39061009902           2020            0.15 
       8 39061010700           2020            0.15 
       9 39061023902           2020            0.013
      10 39061022301           2020            0.247
      # i 216 more rows

