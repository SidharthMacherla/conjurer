#' @title Build identifier
#' @description  Builds strings that could be used as identifiers.
#' @param numOfItems A number. This defines the number of elements to be output.
#' @param prefix A string. This defines the prefix for the strings.
#' @details This function can be used to build an alphanumeric sequence that can be used as a primary key in a data table or a unique identifier of an element.
#' @return A character with the alphanumeric strings is returned. These strings use the prefix that is mentioned in the argument "prefix"
#' @examples
#' userId <- buildId(numOfItems = 3, prefix = "uid")
#' @export
buildId <- function(numOfItems, prefix)
{
  id <- formatC(seq(1, numOfItems), width=nchar(numOfItems), flag=0)
  uid <- paste(prefix, id, sep="")
  return(uid)
}
