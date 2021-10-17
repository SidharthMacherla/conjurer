#' @title A supporting function.
#' @param ... This is a placeholder argument.
#' @description This is used by another internal function \code{\link{genTree}}.
#' @return A dataframe.

#function used in genTree
treeDf<-function(...) {
  outDf <- (as.data.frame(cbind(...)))
  return(outDf)
}
