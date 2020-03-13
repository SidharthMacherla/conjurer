#' @title Extracts Three Consecutive Alphabets of the String
#' @description For a given string, this function extracts three consecutive alphabets. This function is further used by \code{\link{genMatrix}} function.
#' @param s A string. This is the string from which three consecutive alphabets are to be extracted.
#' @return List of three alphabet combinations of the string input.
genTriples <- function(s)
{
  s2 <- unlist(strsplit(s,""))
  triples <- list()
  for(i in seq_along(s2))
  {
    if(i < (length(s2)-1))
    {
      triple <- paste(s2[i],s2[i+1], s2[i+2], sep = "")
      triples <- c(triples,triple)
    }#ends if
  }#ends for
  return(triples)
}
