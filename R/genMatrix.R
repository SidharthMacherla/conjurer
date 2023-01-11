#' @title Generate Frequency Distribution Matrix
#' @description For a given names dataframe and placement, a frequency distribution table is returned.
#' @param dframe A dataframe with one column that has one name per row. These names must be english alphabets from A to Z and must not include any non-alphabet characters such as as hyphen or apostrophe.
#' @param placement A string argument that takes three values namely "first", "last" and "all". Currently, only "first" and "all" are used while the option "last" is a placeholder for future versions of the package **conjurer**
#' @return A table. The rows and columns of the table depend on the argument \emph{placement}. A detailed explanation is as given below in the detail section.
#' @details The purpose of this function is to generate a frequency distribution table of alphabets. There are currently 2 tables that could be generated using this function.
#' The first table is generated using the internal function \code{\link{genFirstPairs}}. For this, the argument \emph{placement} is assigned the value "first". The rows of the table returned by the function represent the first alphabet of the string and the columns represent the second alphabet. The values in the table represent the number of times the combination is observed i.e the combination of the row and column alphabets.
#'
#' The second table is generated using the internal function \code{\link{genTriples}}. For this, the argument \emph{placement} is assigned the value "all". The rows of the table returned by the function represent two consecutive alphabets of the string and the columns represent the third consecutive alphabet. The values in the table represent the number of times the combination is observed i.e the combination of the row and column alphabets.

genMatrix <- function(dframe, placement)
{
  if(placement == "first")
  {
    alphaList <- apply(X = dframe, MARGIN = 1, FUN = function(x) genFirstPairs(x))
    rowStart <- 1
    rowEnd <- 1
    colStart <- 2
    colEnd <- 2
  }else if(placement == "all")
  {
    alphaList <- apply(X = dframe, MARGIN = 1, FUN = function(x) genTriples(x))
    rowStart <- 1
    rowEnd <- 2
    colStart <- 3
    colEnd <- 3
  }
  alphaUnList <- unlist(alphaList, use.names = FALSE)
  alphaUnList <- tolower(alphaUnList)
  alphaUnListDf <- data.frame(alphaUnList)
  names(alphaUnListDf) <- c("alphabets")
  alphaUnListDf$rowAlpha <- substr(alphaUnListDf$alphabets,rowStart,rowEnd)
  alphaUnListDf$colAlpha <- substr(alphaUnListDf$alphabets,colStart,colEnd)
  alphaUnListDf$alphabets <- NULL
  alphaUnListDfTable <- table(alphaUnListDf$rowAlpha, alphaUnListDf$colAlpha)

  return(alphaUnListDfTable)
}
