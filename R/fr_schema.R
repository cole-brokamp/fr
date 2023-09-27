## https://specs.frictionlessdata.io/table-schema
fr_schema <- S7::new_class(
  "fr_schema",
  properties = list(
    fields = S7::class_list,
    missingValues = S7::class_character,
    primaryKey = S7::class_character,
    foreignKeys = S7::class_character
  ),
  validator = function(self) {
    if (!length(self@fields) > 0) {
      "@fields must have at least one field"
    } else if (!all(sapply(self@fields, is_fr_field))) {
      "all items in @fields should be fr_field objects"
    }
  }
)

## fr_schema(fields = list(
##   fr_field(name = "first_field", type = "numeric"),
##   fr_field(name = "second_field", type = "string")
## ))
