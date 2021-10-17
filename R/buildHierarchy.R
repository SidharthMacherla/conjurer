#' @title Generate hierarchical data
#' @description Generates hierarchical data by using an internal function \code{\link{genTree}}. For a working example, please see the vignette.
#' @param type A string. In its current state, this is only a placeholder function and is not mandatory. Currently, only one type of hierarchy is permitted namely \eqn{equalSplit}.
#' @param splits A positive number. This specifies the number of splits at each branch. For instance, if \eqn{split} is 2 then, each branch will have 2 sub-branches.
#' @param numOfLevels A positive number. This specifies the number of layers in the hierarchy.
#' @details This function helps in generating hierarchical data. If there are multiple categorical variables i.e. classes that are mapped to other classes in a hierarchical manner, this function helps in building the same. Some common use cases for this type of data are Linnaean system of classification in life sciences and product hierarchy in retail industry.
#'The number of terminal nodes are dependent on the arguments \eqn{splits} and \eqn{numOfLevels}. More precisely, the number of terminal nodes has the formulation of \eqn{splits^numOfLevels}. For instance, if \eqn{splits} is 2 and \eqn{numOfLevels} is 3, then the number of terminal nodes are \eqn{2^3} i.e. 8. Furthermore, the number of columns of the output dataframe is equal to the \eqn{numOfLevels}. Although a hierarchical data sctructure is often represented as a tree structure, this function outputs the data in a denormalized form i.e a dataframe.
#' @return A dataframe.
#' @examples
#' productHierarchy <- buildHierarchy(type = "equalSplit", splits = 2, numOfLevels = 3)
#' productHierarchy <- buildHierarchy(splits = 2, numOfLevels = 3)
#' @export

buildHierarchy <- function(type, splits, numOfLevels)
{
  #set default values for missing arguments
  #placeholder for types of trees. Eg equal, manual etc.
  type <- missingArgHandler(type,"equalSplit")
  splits <- missingArgHandler(splits,2)
  numOfLevels <- missingArgHandler(numOfLevels,3)

  #error handling
  if(splits <= 0)
  {
    stop("Please enter non zero positive integers for splits")
  }else if(splits > 5)
  {
    warning("Too many splits may not be meaningful. Recommended number of splits is between 2 to 5.")
  }

  if(numOfLevels <= 1)
  {
    stop("Please enter positive integers greated than 1 for numOfLevels")
  }else if(numOfLevels > 5)
  {
    warning("Too many levels may not be meaningful. Recommended numOfLevels is between 3 to 5.")
  }

  #call genTree
  outDf <- genTree(m = splits, depth = numOfLevels)

  return(outDf)
}
