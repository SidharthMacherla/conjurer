#' Build Unique Customer Identifier
#' @param numOfCust A number.
#' @return A character with a unique customer identifiers
#' @examples
#' df <- buildCust(1000)
#' df <- buildCust(223)

#' @export
buildCust <- function(numOfCust)
{
  custId <- buildName(numOfItems = numOfCust, prefix = "cust");
}


