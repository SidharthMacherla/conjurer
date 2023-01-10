#' @title Generate Synthetic Data using uncovr API
#' @description Please refer to the official documentation of uncovr at \emph{https://www.foyi.co.nz/posts/documentation/documentationuncovr/} for a detailed explanation. This function generates data i.e. independent variables and dependent variable. Besides these variables, this function sources the linear function i.e. model formula.This function needs to be used along with other function such as \code{\link{extractDf}} so as to extract relevant portions of the response.
#' @param numOfObs A number. This represents the number of observations in the data. In other words, the number of rows of data that are requested to be generated. The \emph{numOfObs} argument must be a non-negative integer and in the current version, this function accepts a range of 100 to 10,000.
#' @param numOfVars A number. This represents the number of independent variables in the data. In other words, the number of columns besides the dependent variable of data that are requested to be generated. The \emph{numOfVars} argument must be a non-negative integer and in the current version, this function accepts a range of 1 to 100.
#' @param key An alpha numeric. This is the subscription key that can be sourced from the developer portal of uncovr API available at \emph{https://foyi.developer.azure-api.net/}.
#' @param modelObj Optional argument. A glm or lm model object where both the dependent and independent variables are continuous. 
#' @importFrom httr content
#' @importFrom jsonlite fromJSON
#' @return A json with details such as the requested data, model performance metrics and the model formula.
#' @details This is a function that helps in sending the details of the requested data to uncovr API end point and source its response. The purpose of this function can be best understood when explained within the context that is given below. There is a closed source SaaS(Software as a Service) software named \emph{uncovr} that provides an API(Application Programming Interface). In its current state, the SaaS software is free to use with some constraints around the volume of data and the frequency of API calls. One of the functions of \emph{uncovr} API takes an input of number of observations i.e. rows and number of independent variables namely columns and gives an output. The input of the \emph{uncovr} function is required to be sent as part of the body of the html POST functionality. This function \emph{buildModelData} creates the json in the form required by \emph{uncovr} API and sources the response. This function uses an internal function \code{\link{uncovrApi}} to connect to the API endpoint and uses another internal function namely \code{\link{genIndepDepJson}} to build the necessary body of the POST function.

#' @export
buildModelData <- function(numOfObs, numOfVars, key, modelObj)
{
  #set default values for missing arguments
  numOfObs <- missingArgHandler(numOfObs, 1000)
  if(missing(numOfVars) & missing(modelObj))
  {
    numOfVars <- missingArgHandler(numOfVars, 5)  
  }
  
  
  #error handling
  #if subscription key of the uncovr api is missing, stop the process and inform the user.
  if(missing(key) == TRUE)
  {
    stop("Please enter the subscription key for the uncovr API")
  }
  
  #call out the currently acceptable range of number of observations
  if(numOfObs < 100 | numOfObs > 10000)
  {
    #stop("numOfObs must be atleast 100 and not more than 10,000")
  }
  
  #call out the currently acceptable range of number of variables
  if(numOfVars < 1 | numOfVars > 100)
  {
    stop("numOfVars must be atleast 1 and not more than 100")
  }
  
  if(missing(modelObj))
  {
    body <- genIndepDepJson(numOfObs = numOfObs, numOfVars = numOfVars) 
  }else
  {
    body <- genIndepDepJson(numOfObs = numOfObs, numOfVars = numOfVars, modelObj = modelObj)
  }
  
  resp <- uncovrApi(body = body, key = key)
  respAsChar <- httr::content(resp, as="text", type = "application/json", encoding = 'UTF-8')
  respAsJson <- jsonlite::fromJSON(respAsChar)
  
  return(respAsJson)
}
