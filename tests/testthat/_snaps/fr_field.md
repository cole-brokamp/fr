# printing fr_field

    Code
      as_fr_field(letters, name = "letters")
    Message <cliMessage>
      name: letters
      type: string
      title:
      description:
    Output
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(letters, name = "letters", title = "Letters")
    Message <cliMessage>
      name: letters
      type: string
      title: Letters
      description:
    Output
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(letters, name = "letters", description = "Those things in the alphabet.")
    Message <cliMessage>
      name: letters
      type: string
      title:
      description: Those things in the alphabet.
    Output
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(letters, name = "letters", title = "Letters", description = "Those things in the alphabet.")
    Message <cliMessage>
      name: letters
      type: string
      title: Letters
      description: Those things in the alphabet.
    Output
       [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
      [20] "t" "u" "v" "w" "x" "y" "z"

---

    Code
      as_fr_field(factor(letters), name = "letters", title = "Letters", description = "Those things in the alphabet.")
    Message <cliMessage>
      name: letters
      type: string
      title: Letters
      description: Those things in the alphabet.
      constraints: abcdefghijklmnopqrstuvwxyz
    Output
       [1] a b c d e f g h i j k l m n o p q r s t u v w x y z
      Levels: a b c d e f g h i j k l m n o p q r s t u v w x y z

