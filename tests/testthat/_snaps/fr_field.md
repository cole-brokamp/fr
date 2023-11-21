# fr_field printing

    Code
      as_fr_field(factor(letters[1:5]), name = "letters_five", title = "Five Letters",
      description = "The first five letters from `letters` in R.")
    Message <cliMessage>
      letters_five
      - type: string
      - title: Five Letters
      - description: The first five letters from `letters` in R.
      - constraints: enum = a, b, c, d, and e

---

    Code
      as_fr_field(1:10, name = "example_integer")
    Message <cliMessage>
      example_integer
      - type: number

