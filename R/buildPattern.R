#' @title Build a pattern
#' @description Builds data based on a pattern. This function uses another internal function \code{\link{genPattern}}.
#' @param n A natural number. This specifies the number of data points to build.
#' @param parts A natural number. This specifies the parts that make up the pattern.
#' @param probs A number between 0 and 1.
#' @return A vector.
#' @details This function helps in generating data based on a pattern. To explain in simple terms, this function aims to perform the exact opposite of a regular expression i.e regex function. In other words, this function generates data given a generic pattern.
#'The steps in the process of building data from a pattern is as follows.
#' \enumerate{
#' \item Identify the parts that make up the data. Ideally, these parts have a pattern and a probabilistic distribution of their own. For example, a phone number has three parts namely, country code, area code and a number.
#' \item Assign probabilities to each of the above parts. If a part contains only one member, then the corresponding probability must be 1. However, if there are multiple members in the part, then each member must have a probability provided in the respective order.
#' }
#' @examples
#' parts <- list(c("+91","+44","+64"), c(491,324,211), c(7821:8324))
#' probs <- list(c(0.25,0.25,0.50), c(0.30,0.60,0.10), c())
#' phoneNumbers <- buildPattern(n=20,parts = parts, probs = probs)
#' head(phoneNumbers)
#' parts <- list(c("+91","+44","+64"), c("("), c(491,324,211), c(")"), c(7821:8324))
#' probs <- list(c(0.25,0.25,0.50), c(1), c(0.30,0.60,0.10), c(1), c())
#' phoneNumbers <- buildPattern(n=20,parts = parts, probs = probs)
#' head(phoneNumbers)
#' @seealso \code{\link{genPattern}}.
#' @export

buildPattern <- function(n,parts,probs)
{

  patternVector <- character(n)

  orderedList <- vector(mode = "list", length = length(parts))
  for(i in seq_along(orderedList))
  {
    orderedList[[i]]$values <- parts[[i]]
    orderedList[[i]]$probs <- probs[[i]]
  }

  for (j in seq_len(n))
  {
    patternVector[j] <- genPattern(orderedList)
  }

  return(patternVector)
}
