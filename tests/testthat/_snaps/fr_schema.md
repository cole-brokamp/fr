# fr_schema printing

    Code
      read_fr_tdr(fs::path_package("fr", "hamilton_poverty_2020"))@schema
    Message <cliMessage>
      census_tract_id_2020
      - type: string
      - title: Census Tract Identifier
      - description: refers to 2020 vintage census tracts identifiers
      year
      - type: integer
      - title: Year
      - description: The year of the 5-year ACS estimates (e.g., the 2019 ACS covers
      2015 - 2019)
      fraction_poverty
      - type: number
      - title: Fraction of Households in Poverty
      - description: Fraction of households with income below poverty level within
      the past 12 months

