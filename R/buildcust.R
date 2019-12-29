#' @title Build Unique Customer Identifier
#' @description Builds a customer identifier. This is often used as a primary key of the customer dim table in databases.
#' @param numOfCust A number.
#' @return A character with a unique customer identifiers
#' @examples
#' df <- buildCust(numOfCust = 1000)
#' df <- buildCust(numOfCust = 223)

#' @export
buildCust <- function(numOfCust)
{
  custId <- buildName(numOfItems = numOfCust, prefix = "cust");
}


