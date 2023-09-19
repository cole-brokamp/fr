# printing fr_field

    Code
      as_fr_field(letters, name = "letters")
    Output
      letters (string)
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(letters, name = "letters", title = "Letters")
    Output
      letters (string)
      Letters 
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(letters, name = "letters", description = "Those things in the alphabet.")
    Output
      letters (string)
      Those things in the alphabet. 
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(letters, name = "letters", title = "Letters", description = "Those things in the alphabet.")
    Output
      letters (string)
      Letters 
      Those things in the alphabet. 
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(factor(letters), name = "letters", title = "Letters", description = "Those things in the alphabet.")
    Output
      letters (string)
      Letters 
      Those things in the alphabet. 
        *with constraints*
       [1] a b c d e f g h i j k l m n o p q r s t u v w x y z
      Levels: a b c d e f g h i j k l m n o p q r s t u v w x y z

