#' @title Build a Unique Customer Identifier
#' @description Builds a customer identifier. This is often used as a primary key of the customer dim table in databases.
#' @param numOfCust A natural number. This specifies the number of unique customer identifiers to be built.
#' @return A character with unique customer identifiers
#' @details A customer is identified by a unique customer identifier(ID). A customer ID is alphanumeric with prefix "cust" followed by a numeric. This numeric ranges from 1 and extend to the number of customers provided as the argument within the function. For example, if there are 100 customers, then the customer ID will range from cust001 to cust100. This ensures that the customer ID is always of the same length.
#' @examples
#' df <- buildCust(numOfCust = 1000)
#' df <- buildCust(numOfCust = 223)

#' @export
buildCust <- function(numOfCust)
{
  custId <- buildName(numOfItems = numOfCust, prefix = "cust")
}


