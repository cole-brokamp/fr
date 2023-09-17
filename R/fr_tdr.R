fr_tdr <- S7::new_class(
  "fr_tdr",
  properties = list(
    value = S7::class_data.frame,
    name = S7::class_character,
    path = S7::class_character,
    version = S7::class_character,
    title = S7::class_character,
    homepage = S7::class_character,
    description = S7::class_character
  ),
  validator = function(self) {
    x <- self@value
    if (all(sapply(x, is_fr_field))) {
      "all columns or items in @value should be fr_field objects"
    }
  }
)
