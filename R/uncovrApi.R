#' @title POST Function for Calling uncovr API
#' @description This function makes the POST call to the \emph{uncovr} API.
#' @param body A json with the details of the independent and dependent variable.
#' @param key An alpha numeric. This is the subscription key that can be sourced from the developer portal of uncovr API available at \emph{https://foyi.developer.azure-api.net/}.
#' @importFrom httr POST add_headers
#' @return A .
#' @details The purpose of this function can be best understood when explained within the context that is given below. There is a closed source SaaS(Software as a Service) software named \emph{uncovr} that provides an API(Application Programming Interface). In its current state, the SaaS software is free to use with some constraints around the volume of data and the frequency of API calls. One of the functions of \emph{uncovr} API takes an input of number of observations i.e. rows and number of independent variables namely columns and gives an output. This function \emph{uncovrApi} makes the connection to \emph{uncovr} API and sources the response.

#' #function to call uncovr api
uncovrApi <- function(body,key)
{
  httr::POST("https://foyi.azure-api.net/uncovr/uncovr/",
             add_headers("Ocp-Apim-Subscription-Key" = key),
             query = list("funcName" = "indepAndDep"),
             body = body, encode = "json")
}

