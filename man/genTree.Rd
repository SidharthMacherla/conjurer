% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/genTree.R
\name{genTree}
\alias{genTree}
\title{Generate complete m-ary connected graph}
\usage{
genTree(m, depth)
}
\arguments{
\item{m}{A positive number. This specifies the number of splits at each branch.}

\item{depth}{A positive number. This specifies the number of levels of the tree.}
}
\value{
A dataframe.
}
\description{
Generates an m-ary connected graph that is complete. This function is used by another internal function \code{\link{buildHierarchy}}.
}
\details{
This function helps in generating data that is of a tree structure. To explain further, this function generates a data where there are less number of classes i.e. branches at the top i.e. the root and increase in number and increase towards the end i.e. the leaf nodes. The number of terminal nodes are dependent on the arguments \eqn{m} and \eqn{depth}. More precisely, the number of terminal nodes has the formulation of \deqn{m^depth}. For instance, if \eqn{m} is 2 and \eqn{depth} is 3, then the number of terminal nodes are \eqn{2^3} i.e. 8.
}
\seealso{
[buildHierarchy()] to build hierarchical data.
}
