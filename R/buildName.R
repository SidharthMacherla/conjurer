#' @title Build Dynamic Strings
#' @description  Builds strings that could be further used as identifiers. This is an internal function and is currently not exported in the package.
#' @param numOfItems A number. This defines the number of elements to be output.
#' @param prefix A string. This defines the prefix for the strings. For example, the function buildCust uses this function and passes the prefix "cust" while the function buildProd passes the prefix "sku"
#' @details This function is used by other internal functions namely, buildCust and buildProd to produce the alphanumeric identifiers for customers and products respectively.
#' @return A character with the alphanumeric strings is returned. These strings use the prefix that is mentioned in the argument "prefix"
buildName <- function(numOfItems, prefix)
{
  id <- formatC(seq(1, numOfItems), width=nchar(numOfItems), flag=0)
  uid <- paste(prefix, id, sep="")
  return(uid)
}
