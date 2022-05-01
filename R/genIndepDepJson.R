#' @title Generate Body for the POST Function of Uncovr
#' @description This is an internal function used by \code{\link{buildModelData}} function.
#' @param numOfObs A number. This represents the number of observations in the data. In other words, the number of rows of data that are requested to be generated. The \emph{numOfObs} argument must be a non-negative integer.
#' @param numOfVars A number. This represents the number of variables in the data. In other words, the number of columns of data that are requested to be generated. The \emph{numOfVars} argument must be a non-negative integer.
#' @importFrom jsonlite toJSON
#' @return A json with the details of independent variable and the dependent variable. The format of this json is as required by the \emph{uncovr} api end point.
#' @details This function is one of the core functions for the generation of data that comprises of independent and dependent variables. The purpose of this function can be best understood when explained within the context that is given below. There is a closed source SaaS(Software as a Service) software named \emph{uncovr} that provides an API(Application Programming Interface). In its current state, the SaaS software is free to use with some constraints around the volume of data and the frequency of API calls. One of the functions of \emph{uncovr} API takes an input of number of observations i.e. rows and number of independent variables namely columns and gives an output. The input of the \emph{uncovr} function is required to be sent as part of the body of the html POST functionality. This function \emph{genIndepDepJson} creates the json in the form required by \emph{uncovr} API.

genIndepDepJson <- function(numOfObs, numOfVars)
{
  #Since this is one of the core functions, no error handling is put in place to ensure faster run time.

  #build outer list scaffolding
  ivNames <- buildName(numOfItems = numOfVars, prefix = "iv")
  ivList <- vector("list", numOfVars)
  names(ivList) <- ivNames
  #build inner list scaffolding
  for(iv in ivNames)
  {
    #build attributes of independent variable
    ivAttribs <- c("noOfpoints", "upperBound", "lowerBound", "dataType")
    ivAttribList <- vector("list", length(ivAttribs))
    names(ivAttribList) <- ivAttribs
    ivList[[iv]] <- ivAttribList
  }

  for(i in ivNames)
  {
    #currently, upperBound range is hard coded. This can later be provided as a parameter to the users.
    ivList[[i]]$noOfpoints <- numOfObs
    ivList[[i]]$upperBound <- sample(0.01:100,1)
    ivList[[i]]$lowerBound <- (-1*(ivList[[i]]$upperBound))
    ivList[[i]]$dataType <- "continuous"
  }

  comboList <- vector("list", 2)
  names(comboList) <- c("iv", "dv")
  comboList[["iv"]] <- ivList
  comboList[["dv"]]$dataType <- "continuous"
  outJson <- jsonlite::toJSON(comboList, matrix = c("rowmajor"), auto_unbox = TRUE, pretty = TRUE)
  return(outJson)
}
