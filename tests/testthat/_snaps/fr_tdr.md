# fr_tdr works

    Code
      d_fr
    Message <cliMessage>
      ── mtcars ──
      • version: 0.9.1
      • title: Motor Trend Car Road Tests
      • homepage: <https://rdrr.io/r/datasets/mtcars.html>
      • description: The data was extracted from the 1974 Motor Trend US magazine,
      and comprises fuel consumption and 10 aspects of automobile design and
      performance for 32 automobiles (1973–74 models).
    Output
      # A tibble: 32 x 11
           mpg cyl    disp    hp  drat    wt  qsec    vs    am  gear  carb
         <dbl> <fct> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
       1  21   6      160    110  3.9   2.62  16.5     0     1     4     4
       2  21   6      160    110  3.9   2.88  17.0     0     1     4     4
       3  22.8 4      108     93  3.85  2.32  18.6     1     1     4     1
       4  21.4 6      258    110  3.08  3.22  19.4     1     0     3     1
       5  18.7 8      360    175  3.15  3.44  17.0     0     0     3     2
       6  18.1 6      225    105  2.76  3.46  20.2     1     0     3     1
       7  14.3 8      360    245  3.21  3.57  15.8     0     0     3     4
       8  24.4 4      147.    62  3.69  3.19  20       1     0     4     2
       9  22.8 4      141.    95  3.92  3.15  22.9     1     0     4     2
      10  19.2 6      168.   123  3.92  3.44  18.3     1     0     4     4
      # i 22 more rows

---

    Code
      as_fr_tdr(mtcars, name = "mtcars")
    Message <cliMessage>
      ── mtcars ──
    Output
      # A tibble: 32 x 11
           mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
         <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
       1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
       2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
       3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
       4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
       5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
       6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
       7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
       8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
       9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
      10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
      # i 22 more rows

---

    Code
      as_list(d_fr)
    Output
      $name
      [1] "mtcars"
      
      $path
      character(0)
      
      $version
      [1] "0.9.1"
      
      $title
      [1] "Motor Trend Car Road Tests"
      
      $homepage
      [1] "https://rdrr.io/r/datasets/mtcars.html"
      
      $description
      [1] "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)."
      
      $schema
      $schema$fields
      $schema$fields$mpg
      $schema$fields$mpg$name
      [1] "mpg"
      
      $schema$fields$mpg$type
      [1] "number"
      
      
      $schema$fields$cyl
      $schema$fields$cyl$name
      [1] "cyl"
      
      $schema$fields$cyl$type
      [1] "string"
      
      $schema$fields$cyl$constraints
      $schema$fields$cyl$constraints$enum
      [1] "4" "6" "8"
      
      
      
      $schema$fields$disp
      $schema$fields$disp$name
      [1] "disp"
      
      $schema$fields$disp$type
      [1] "number"
      
      
      $schema$fields$hp
      $schema$fields$hp$name
      [1] "hp"
      
      $schema$fields$hp$type
      [1] "number"
      
      
      $schema$fields$drat
      $schema$fields$drat$name
      [1] "drat"
      
      $schema$fields$drat$type
      [1] "number"
      
      
      $schema$fields$wt
      $schema$fields$wt$name
      [1] "wt"
      
      $schema$fields$wt$type
      [1] "number"
      
      
      $schema$fields$qsec
      $schema$fields$qsec$name
      [1] "qsec"
      
      $schema$fields$qsec$type
      [1] "number"
      
      
      $schema$fields$vs
      $schema$fields$vs$name
      [1] "vs"
      
      $schema$fields$vs$type
      [1] "number"
      
      
      $schema$fields$am
      $schema$fields$am$name
      [1] "am"
      
      $schema$fields$am$type
      [1] "number"
      
      
      $schema$fields$gear
      $schema$fields$gear$name
      [1] "gear"
      
      $schema$fields$gear$type
      [1] "number"
      
      
      $schema$fields$carb
      $schema$fields$carb$name
      [1] "carb"
      
      $schema$fields$carb$type
      [1] "number"
      
      
      
      

