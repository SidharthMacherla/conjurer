% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/buildId.R
\name{buildId}
\alias{buildId}
\title{Build identifier}
\usage{
buildId(numOfItems, prefix)
}
\arguments{
\item{numOfItems}{A number. This defines the number of elements to be output.}

\item{prefix}{A string. This defines the prefix for the strings.}
}
\value{
A character with the alphanumeric strings is returned. These strings use the prefix that is mentioned in the argument "prefix"
}
\description{
Builds strings that could be used as identifiers.
}
\details{
This function can be used to build an alphanumeric sequence that can be used as a primary key in a data table or a unique identifier of an element.
}
\examples{
userId <- buildId(numOfItems = 3, prefix = "uid")
}
