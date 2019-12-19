#' Build Dynamic Strings
#' @param numOfItems A number.
#' @param prefix A string.
#' @return A character with the strings is returned. These strings use the prefix that is mentioned in the argument "prefix"
buildName <- function(numOfItems, prefix)
{
  id <- formatC(seq(1, numOfItems), width=nchar(numOfItems), flag=0);
  uid <- paste(prefix, id, sep="");
  return(uid)
}
