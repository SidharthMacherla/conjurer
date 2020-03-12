#' @title Extracts the First Two Alphabets of the String
#' @description For a given string, this function extracts the first two alphabets. This function is further used by \code{\link{genMatrix}} function.
#' @param s A string. This is the string from which the first two alphabets are to be extracted.
#' @return First two alphabets of the string input.
genFirstPairs <- function(s)
{
  s2 <- unlist(strsplit(s,""))
  pair <- paste(s2[1],s2[2], sep = "")
  return(pair)
}
