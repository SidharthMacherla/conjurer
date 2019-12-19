#' Handle Missing Arguments in Function
#' @param argMissed A variable.
#' @param argDefault A variable.
#' @return The default value of the missing argument
#function to put default values for missing parameters
missingArgHandler <- function(argMissed,argDefault)
{
  out <- ifelse(missing(argMissed),argDefault,argMissed);
  return(out)
}
