#' @title Extract Dataframe from uncovr API Response
#' @description This function extracts the dataframe from the output of the \code{\link{buildModelData}} function.
#' @param uncovrJson A json. This is the output of the \code{\link{buildModelData}} function.
#' @return A dataframe with dependent and independent variables. The independent variables are prefixed with \emph{iv} and the dependent variable is named \emph{dv}.
#' @details The purpose of this function can be best understood when explained within the context that is given below. There is a closed source SaaS(Software as a Service) software named \emph{uncovr} that provides an API(Application Programming Interface). In its current state, the SaaS software is free to use with some constraints around the volume of data and the frequency of API calls. One of the functions of \emph{uncovr} API takes an input of number of observations i.e. rows and number of independent variables namely columns and gives an output. This output is in the form of a json file and has many other elements besides the dependent and independent variables. This function \emph{extractDf} helps in extracting the dataframe from the json.

#' @export
extractDf <- function(uncovrJson)
{
  dv <- data.frame(uncovrJson$depVar)
  names(dv) <- c("dv")
  iv <- data.frame(t(uncovrJson$indepVars), row.names = NULL)
  names(iv) <- buildName(numOfItems = length(iv), prefix = "iv")
  outDf <- cbind(iv,dv)

  return(outDf)
}
