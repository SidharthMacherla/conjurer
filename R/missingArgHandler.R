#' @title Handle Missing Arguments in Function
#' @description Replaces the missing argument with the default value. This is an internal function and is currently not exported in the package.
#' @param argMissed A variable. This is the argument that needs to be handled.
#' @param argDefault A variable. This is the default value.
#' @return The default value of the missing argument
missingArgHandler <- function(argMissed,argDefault)
{
  out <- ifelse(missing(argMissed),argDefault,argMissed);
  return(out)
}
