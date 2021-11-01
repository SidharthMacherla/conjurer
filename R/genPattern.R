#' @title Generate a pattern
#' @description Generates data based on a pattern. This function is used by another internal function \code{\link{buildPattern}}.
#' @param orderedList A list of lists. The element \eqn{values} of the sublist is a vector of characters(string or numeric or special character) and the element \eqn{probs} is a vector of probabilities. The range of the probs is 0 to 1 and length of the \eqn{probs} vector is either equal to length of \eqn{values} or NULL.
#' @details This function helps in generating data based on a pattern. To explain in simple terms, this function aims to perform the exact opposite of a regular expression i.e regex function. In other words, this function generates data given a generic pattern.
#'The input is a list of components that make up the pattern. Each component i.e element of the list is a also list with two vectors namely \eqn{values} and \eqn{probs}. The vector \eqn{values} has the set of values out of which one of them is selected randomly. If this random selection is supposed to be completely random, then the next vector \eqn{probs} can be left empty i.e. NULL. However, if the random selection of values is expected to follow a a pre-determined probabilistic distribution, then the probabilities must be provided explicitly. To explain further, if there are three values \eqn{a}, \eqn{b}, \eqn{c} and their probabilistic distribution must be 25 percent, 50 percent and 25 percent respectively, then the vector \eqn{values} will take the form \eqn{c(a,b,c)} and the vector \eqn{probs} will take the form \eqn{c(0.25,0.5,0.25)}.
#'@return A character vector.
#'@seealso [buildPattern()]

#all error handling will be done in the build function to improve speed
genPattern <- function(orderedList)
{
  elementSeq <- c()
  for(i in seq_along(orderedList))
  {
    elements <- orderedList[[i]]$values
    probs <- orderedList[[i]]$probs
    tempSeq <- sample(elements, size=1, replace = TRUE, prob = probs)
    elementSeq <- paste0(elementSeq,tempSeq)
  }
  return(elementSeq)
}
