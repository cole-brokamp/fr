
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fr

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/fr)](https://CRAN.R-project.org/package=fr)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`fr` provides `fr_field` and `fr_tdr` objects for implementing
[frictionless](https://specs.frictionlessdata.io)
[tabular-data-resource](https://specs.frictionlessdata.io/tabular-data-resource)
standards in R.

## Installation

You can install the development version of {fr} from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("cole-brokamp/fr")
```

## Usage

``` r
library(fr)
```

### Frictionless Field

Create a frictionless field (i.e., `fr_field` object) by converting an R
vector and specifying named [field
descriptors](https://specs.frictionlessdata.io/table-schema/#field-descriptors):

``` r
set.seed(1)
uid <-
  replicate(6, paste0(sample(c(letters, 0:9), 8, TRUE), collapse = "")) |>
  as_fr_field(name = "uid",
              title = "Unique Identifier",
              description = "Each uid is composed of 8 random alphanumeric characters.")
```

Printing works as usual except that `fr_field` objects prepend extra
lines for the Frictionless attributes:

``` r
uid
#> name: uid
#> type: string
#> title: Unique Identifier
#> description: Each uid is composed of 8 random alphanumeric characters.
#> [1] "da7wnr6u" "ujgiouy7" "yo6t8fjt" "1twfyffx" "5nbrvnaf" "wfkq9myy"
```

Extract the descriptors as a list using `fr_desc`:

``` r
fr_desc(uid)
#> $name
#> [1] "uid"
#> 
#> $type
#> [1] "string"
#> 
#> $title
#> [1] "Unique Identifier"
#> 
#> $description
#> [1] "Each uid is composed of 8 random alphanumeric characters."
```

`fr_field` objects can be used anywhere that the underlying vector in
`@value` can be used. Because `uid`’s Frictionless `type` is `string`,
the underlying vector in this case is a character vector.

``` r
grepl("[[:alnum:]]", uid)
#> [1] TRUE TRUE TRUE TRUE TRUE TRUE
paste(uid, collapse = "-")
#> [1] "da7wnr6u-ujgiouy7-yo6t8fjt-1twfyffx-5nbrvnaf-wfkq9myy"
```

Explicitly drop the Frictionless attributes and extract just the
underlying vector that contains the data vector with `as_vector()`:

``` r
as_vector(uid)
#> [1] "da7wnr6u" "ujgiouy7" "yo6t8fjt" "1twfyffx" "5nbrvnaf" "wfkq9myy"
```

### Frictionless Tabular-Data-Resource

Convert a data frame into a frictionless tabular-data-resource (i.e.,
`fr_tdr` object) with `as_fr_tdr()`. An `fr_tdr` object is essentially a
list of `fr_field`s with table-specific metadata descriptors. Here, we
create some metadata based on `?mtcars`:

``` r
d_fr <-
  mtcars |>
  tibble::as_tibble() |>
  as_fr_tdr(name = "mtcars",
            version = "0.9.1",
            title = "Motor Trend Car Road Tests",
            homepage = "https://rdrr.io/r/datasets/mtcars.html",
            description = "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).")
```

Print the `fr_tdr` object to view all of the table-specific metadata
descriptors and the underlying data frame:

``` r
d_fr
#> name: mtcars
#> path:
#> version: 0.9.1
#> title: Motor Trend Car Road Tests
#> homepage: <https://rdrr.io/r/datasets/mtcars.html>
#> description: The data was extracted from the 1974 Motor Trend US magazine, and
#> comprises fuel consumption and 10 aspects of automobile design and performance
#> for 32 automobiles (1973–74 models).
#> # A tibble: 32 × 11
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
#>  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
#>  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
#>  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
#>  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
#>  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
#>  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
#>  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
#>  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
#> 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
#> # ℹ 22 more rows
```

Add a `name` metadata descriptor for each field in the `fr_tdr` object
by using the `@` accessor

``` r
# TODO
```

Add another descriptor, but just for some of the fields:

``` r
# TODO
## d_fr$disp@description
```

Using `str()` provides a useful overview of the structure of a `fr_tdr`
object, including all field-specific metadata, table-specific metadata,
and the underlying `@value` data vector:

``` r
str(d_fr)
#> <fr_tdr>
#>  @ fields     :List of 11
#>  .. $ mpg : <fr_field>
#>  ..  ..@ value      : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
#>  ..  ..@ name       : chr "mpg"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ cyl : <fr_field>
#>  ..  ..@ value      : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
#>  ..  ..@ name       : chr "cyl"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ disp: <fr_field>
#>  ..  ..@ value      : num [1:32] 160 160 108 258 360 ...
#>  ..  ..@ name       : chr "disp"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ hp  : <fr_field>
#>  ..  ..@ value      : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
#>  ..  ..@ name       : chr "hp"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ drat: <fr_field>
#>  ..  ..@ value      : num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#>  ..  ..@ name       : chr "drat"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ wt  : <fr_field>
#>  ..  ..@ value      : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
#>  ..  ..@ name       : chr "wt"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ qsec: <fr_field>
#>  ..  ..@ value      : num [1:32] 16.5 17 18.6 19.4 17 ...
#>  ..  ..@ name       : chr "qsec"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ vs  : <fr_field>
#>  ..  ..@ value      : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
#>  ..  ..@ name       : chr "vs"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ am  : <fr_field>
#>  ..  ..@ value      : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
#>  ..  ..@ name       : chr "am"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ gear: <fr_field>
#>  ..  ..@ value      : num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
#>  ..  ..@ name       : chr "gear"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ carb: <fr_field>
#>  ..  ..@ value      : num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
#>  ..  ..@ name       : chr "carb"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  @ name       : chr "mtcars"
#>  @ path       : chr(0) 
#>  @ version    : chr "0.9.1"
#>  @ title      : chr "Motor Trend Car Road Tests"
#>  @ homepage   : chr "https://rdrr.io/r/datasets/mtcars.html"
#>  @ description: chr "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of "| __truncated__
```

Use `fr_schema()` to extract the metadata for each field in a list. Pair
this with [listviewer](https://cran.r-project.org/package=listviewer)
for an interactive list viewer:

``` r
fr_schema(d_fr) |>
    listviewer::jsonedit(mode = "view")
```

Accessor functions work as they do with data frames and tibbles, but
return a `fr_field` or `td_tdr` object:

``` r
d_fr[["disp"]] |> class()
#> [1] "fr_field"  "S7_object"

d_fr$disp |> class()
#> [1] "fr_field"  "S7_object"

d_fr["disp"] |> class()
#> [1] "fr_tdr"    "S7_object"
```

`fr_field` objects can be used mostly anywhere that the underlying data
frame can be used.

``` r
lm(mpg ~ cyl + disp + wt, data = d_fr)
#> 
#> Call:
#> lm(formula = mpg ~ cyl + disp + wt, data = d_fr)
#> 
#> Coefficients:
#> (Intercept)          cyl         disp           wt  
#>   41.107678    -1.784944     0.007473    -3.635677
```

Explicitly drop the Frictionless attributes and extract just the
underlying data frame with `as_data_frame()` or `as_tibble()`:

``` r
tibble::as_tibble(d_fr)
#> # A tibble: 32 × 11
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
#>  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
#>  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
#>  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
#>  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
#>  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
#>  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
#>  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
#>  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
#> 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
#> # ℹ 22 more rows

summary(d_fr)
#>    Length    Class1    Class2      Mode 
#>         1    fr_tdr S7_object        S4

summary(as_data_frame(d_fr))
#>       mpg             cyl             disp             hp       
#>  Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  
#>  1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  
#>  Median :19.20   Median :6.000   Median :196.3   Median :123.0  
#>  Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7  
#>  3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0  
#>  Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0  
#>       drat             wt             qsec             vs        
#>  Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000  
#>  1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000  
#>  Median :3.695   Median :3.325   Median :17.71   Median :0.0000  
#>  Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375  
#>  3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000  
#>  Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000  
#>        am              gear            carb      
#>  Min.   :0.0000   Min.   :3.000   Min.   :1.000  
#>  1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
#>  Median :0.0000   Median :4.000   Median :2.000  
#>  Mean   :0.4062   Mean   :3.688   Mean   :2.812  
#>  3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
#>  Max.   :1.0000   Max.   :5.000   Max.   :8.000
```
