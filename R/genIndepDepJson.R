#' @title Generate Body for the POST Function of Uncovr
#' @description This is an internal function used by \code{\link{buildModelData}} function.
#' @param numOfObs A number. This represents the number of observations in the data. In other words, the number of rows of data that are requested to be generated. The \emph{numOfObs} argument must be a non-negative integer.
#' @param numOfVars A number. This represents the number of variables in the data. In other words, the number of columns of data that are requested to be generated. The \emph{numOfVars} argument must be a non-negative integer.
#' @param modelObj An optional argument. An lm or glm model object. The current limitation is that the independent and dependent variables must be continuous.
#' @importFrom jsonlite toJSON
#' @importFrom stats variable.names
#' @return A json with the details of independent variable and the dependent variable. The format of this json is as required by the \emph{uncovr} api end point.
#' @details This function is one of the core functions for the generation of data that comprises of independent and dependent variables. The purpose of this function can be best understood when explained within the context that is given below. There is a proprietary SaaS(Software as a Service) software named \emph{uncovr} that provides an API(Application Programming Interface). In its current state, the SaaS software is free to use with some constraints around the volume of data and the frequency of API calls. One of the functions of \emph{uncovr} API takes is to source inputs such as number of observations i.e. rows and number of independent variables namely columns and gives an output. The input of the \emph{uncovr} function is required to be sent as part of the body of the html POST functionality. This function \emph{genIndepDepJson} creates the json in the form required by \emph{uncovr} API.
#' As an optional argument, an lm or glm model object can be passed using the \emph{modelObj} argument. This will ensure that the coefficients of the independent variables are sourced from the model object instead of generating  randomly by the \emph{uncovr} API. The current limitation is that the independent and dependent variables must be continuous.

genIndepDepJson <- function(numOfObs, numOfVars, modelObj)
{
  #Since this is one of the core functions, no error handling is put in place to ensure faster run time.
  modelFlag <- ifelse(missing(modelObj),0,1)
  #build outer list scaffolding
  if(modelFlag==0)
  {
    ivNames <- buildName(numOfItems = numOfVars, prefix = "iv")
    ivList <- vector("list", numOfVars)
    names(ivList) <- ivNames
  }else
  {
    ivNames <- stats::variable.names(modelObj)
    ivNames <- ivNames[! ivNames %in% c("(Intercept)")]
    numOfIv <- length(ivNames)
    ivList <- vector("list", numOfIv)
    names(ivList) <- ivNames
    modelSummary <- summary(modelObj)
    intercept <- modelSummary $coefficients["(Intercept)","Estimate"]
  }

  #build inner list scaffolding
  for(iv in ivNames)
  {
    #build attributes of independent variable
    ivAttribs <- ifelse(modelFlag==0,c("noOfpoints", "upperBound", "lowerBound", "dataType"),
                        c("noOfpoints", "upperBound", "lowerBound", "slope", "dataType"))

    ivAttribList <- vector("list", length(ivAttribs))
    names(ivAttribList) <- ivAttribs
    ivList[[iv]] <- ivAttribList
  }

  for(i in ivNames)
  {
    ivList[[i]]$noOfpoints <- numOfObs
    if(modelFlag==0)
    {
      ivList[[i]]$upperBound <- sample(0.01:100,1)
      ivList[[i]]$lowerBound <- (-1*(ivList[[i]]$upperBound))
    }else
    {
      ivList[[i]]$upperBound <- max(modelObj$model[i])
      ivList[[i]]$lowerBound <- min(modelObj$model[i])
      ivList[[i]]$slope <- modelSummary$coefficients[i,"Estimate"]
    }
    #Currently, the datatype of the independent variable is continuous only.
    ivList[[i]]$dataType <- "continuous"
  }
  if(modelFlag==0)
  {
    comboList <- vector("list", 2)
    names(comboList) <- c("iv", "dv")
    comboList[["iv"]] <- ivList
    comboList[["dv"]]$dataType <- "continuous"
  }else
  {
    comboList <- vector("list", 3)
    names(comboList) <- c("iv", "dv", "intercept")
    comboList[["iv"]] <- ivList
    comboList[["dv"]]$dataType <- "continuous"
    comboList[["intercept"]] <- intercept
  }

  outJson <- jsonlite::toJSON(comboList, matrix = c("rowmajor"), auto_unbox = TRUE, pretty = TRUE)
  return(outJson)
}

