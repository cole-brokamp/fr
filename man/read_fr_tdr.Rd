% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_fr_tdr.R
\name{read_fr_tdr}
\alias{read_fr_tdr}
\title{read a tabular-data-resource into R}
\usage{
read_fr_tdr(file)
}
\arguments{
\item{file}{Either a path to a file, a connection, or literal data (either a
single string or a raw vector). \code{file} can also be a character vector
containing multiple filepaths or a list containing multiple connections.

Files ending in \code{.gz}, \code{.bz2}, \code{.xz}, or \code{.zip} will be automatically
uncompressed. Files starting with \verb{http://}, \verb{https://}, \verb{ftp://}, or
\verb{ftps://} will be automatically downloaded. Remote gz files can also be
automatically downloaded and decompressed.

Literal data is most useful for examples and tests. To be recognised as
literal data, wrap the input with \code{I()}.}
}
\value{
a \link[=fr-package]{fr_tdr} object
}
\description{
read a tabular-data-resource into R
}
\details{
A file path (or url) representing a folder
that contains a "tabular-data-resource.yaml" can
be used in \code{file}.
}
\examples{
read_fr_tdr(fs::path_package("fr", "hamilton_poverty_2020"))
}
