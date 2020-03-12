#' @title Generate Names
#' @description Generates names based on a given training data or using the default data
#' @param dframe A dataframe. This argument is passed on to another function \code{\link{genMatrix}} for generating an alphabet frequency table. This dataframe is single column dataframe with rows that contain names. These names must only contain english alphabets(upper or lower case) from A to Z.
#' @param numOfNames A numeric. This specifies the number of names to be generated. It should be non-zero natural number.
#' @param minLength A numeric. This specifies the minimum number of alphabets in the name. It must be a non-zero natural number.
#' @param maxLength A numeric. This specifies the maximum number of alphabets in the name. It must be a non-zero natural number.
#' @details This function generates names. There are two options to generate names. The first option is to use an existing sample of names and generate names. The second option is to use the default table of prior probabilities.
#' @return A list of names.
#' @examples
#' buildNames(numOfNames = 3, minLength = 5, maxLength = 7)
#' @export
buildNames <- function(dframe, numOfNames, minLength, maxLength)
{
  #if training data is provided, build the matrix. Otherwise, use the default matrix
  if(!missing(dframe))
  {
    #generate alphamatrix
    alphaMatrixFirst <- genMatrix(dframe,"first")
    alphaMatrixAll <- genMatrix(dframe,"all")
    alphaMatrixLast <- genMatrix(dframe,"last")
  }

  #build top frequency alphas
  topAlphas <- rowSums(alphaMatrixFirst)
  topAlphas <- topAlphas[order(-topAlphas)]

  #select the high frequency beginning alphabets
  n <- sample(topAlphas[1:13],numOfNames, replace = TRUE)
  custNames <- list()
  for(i in seq_along(n))
  {
    firstAlpha <- names(n[i])
    secondAlpha <- nextAlphaProb(alphaMatrix = alphaMatrixFirst, currentAlpha = firstAlpha, placement = "first")
    custName <- list(firstAlpha,secondAlpha)
    prevAlpha <- paste0(unlist(custName),collapse = "")
    nameLength <- sample(minLength:maxLength, 1, replace = FALSE)
    for(j in 3:nameLength)
    {
      nextAlpha <- nextAlphaProb(alphaMatrix = alphaMatrixAll, currentAlpha = prevAlpha, placement = "all")
      custName <- list(custName,nextAlpha)
      custName <- unlist(custName)
      prevAlpha <- paste0(custName[length(custName)-1], custName[length(custName)], collapse = "")
    }#ends inner for
    custName <- paste0(custName, collapse = "")
    custNames <- c(unlist(custNames), custName)
  }#ends for
  return(custNames)
}

