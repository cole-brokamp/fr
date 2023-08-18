`fr` is a package for implementing the [**Fr**ctionless](https://specs.frictionlessdata.io) [Table Schema](https://specs.frictionlessdata.io/table-schema) Standards in R.


For tabular-data-resource:

- Required: name, path, profile, schema (with a set of descriptors for each field)
- Optional: version, title, homepage, description

How to make a markdown/html button for a tabular-data-resource to list the version number and have a link for download?  *or* to display an html popup or link to the metadata and schema???

R function to do a rendered html file of metadata?? (Just use json and use browser to display the raw json?)

Implement a subset of the tabular data resource functionality. Exclude foregin and primary keys, which allows for the removal of `fields` by collapsing the structure up one level into `schema`. Schema is basically a special type of descriptor that can have many descriptors in it for each data field. This makes it less confusing with the "fields" terminology used in vctrs. Consider this as `schema`.


Vector resources:

- https://github.com/krlmlr/awesome-vctrs
- https://blog.earo.me/2019/11/03/practical-guide-to-s3/
- https://github.com/jessesadler/debvctrs
- https://vctrs.r-lib.org/ and https://vctrs.r-lib.org/articles/s3-vector.html
- https://adv-r.hadley.nz/oo.html and https://adv-r.hadley.nz/s3.html#s3-methods

Key functions:

- `structure()`, `class() <- `
- `names()`, `setNames()`
- `attributes()`, `attr()`, (`purrr::attr_getter`)
- `sloop::`

take or keep dataset attributes in DESCRIPTION files: https://r-pkgs.org/description.html#sec-description-title-and-description
