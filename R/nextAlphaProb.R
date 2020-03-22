#' @title Generate Next Alphabet
#' @description Generates next alphabet based on prior probabilities.
#' @param alphaMatrix A table. This table is generated using the \code{\link{genMatrix}} function .
#' @param currentAlpha A string. This is the alphabet(s) for which the next alphabet is generated.
#' @param placement A string. This takes one of the two values namely "first" or "all".
#' @return The next alphabet following the input alphabet(s) passed by the argument \emph{currentAlpha}.
#' @details The purpose of this function is to generate the next alphabet for a given alphabet(s). This function uses prior probabilities to generate the next alphabet. Although there are two types of input tables passed into the function by using the parameter \emph{alphaMatrix}, the process to generate the next alphabet remains the same as given below.
#'
#' Firstly, the input table contains frequencies of the combination of current alphabet \emph{currentAlpha} (represented by rows) and next alphabet(represented by columns). These frequencies are converted into a percentage at a row level. This means that for each row, the sum of all the column values will add to 1.
#'
#' Secondly, for the given \emph{currentAlpha}, the table is looked up for the corresponding column where the probability is the highest. The alphabet for the column with maximum prior probability is selected as the next alphabet and is returned by the function.

nextAlphaProb <- function(alphaMatrix, currentAlpha, placement)
{
  #matrixSubsetCur <- alphaMatrix[currentAlpha,]
  tryCatchTest <- try(matrixSubsetCur <- alphaMatrix[currentAlpha,], silent = TRUE)
  if(class(tryCatchTest) == "try-error")
  {
    nextAlphaFinal <- "doesNotExist"
  }else
  {
    sumRowProb <- prop.table(matrixSubsetCur)

    #select the range of sumRowProb This is particularly important if the length of sumRowProb is less than 3
    maxRange <- min(length(sumRowProb), 3)

    #add randomness
    randNum <- sample(1:maxRange,1)

    #compute prob(current)
    listOfProbs <- list()
    for(i in seq_along(sumRowProb))
    {
      #compute prob(next). Note that row or column sum does not matter as its the same.
      nextAlpha <- names(sumRowProb[i])
      #compute prob(next|current) testing with just next alpha
      probNextAlphaGivenCur <- sumRowProb[nextAlpha]
      listOfProbs <- c(listOfProbs,list(probNextAlphaGivenCur))
    }
    #pick the next alphabet randomly from the top few highest probabilities
    unlistOfProbs <- unlist(listOfProbs)
    sortedProb <- sort(unlistOfProbs, decreasing = TRUE)
    nextAlphaFinal <- names(sortedProb[randNum])
  }
  return(nextAlphaFinal)
}
