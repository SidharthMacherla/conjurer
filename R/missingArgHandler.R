#' @title Handle Missing Arguments in Function
#' @description Replaces the missing argument with the default value. This is an internal function and is currently not exported in the package.
#' @param argMissed This is the argument that needs to be handled.
#' @param argDefault This is the default value of the argument that is missing in the function called.
#' @details This function plays the role of error handler by setting the default values of the arguments when a function is called without specifying any arguments.
#' @return The default value of the missing argument.
missingArgHandler <- function(argMissed,argDefault)
{
  out <- ifelse(missing(argMissed),argDefault,argMissed)
  return(out)
}
