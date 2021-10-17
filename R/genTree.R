#' @title Generate complete m-ary connected graph
#' @description Generates an m-ary connected graph that is complete. This function is used by another internal function \code{\link{buildHierarchy}}.
#' @param m A positive number. This specifies the number of splits at each branch.
#' @param depth A positive number. This specifies the number of levels of the tree.
#' @details This function helps in generating data that is of a tree structure. To explain further, this function generates a data where there are less number of classes i.e. branches at the top i.e. the root and increase in number and increase towards the end i.e. the leaf nodes. The number of terminal nodes are dependent on the arguments \eqn{m} and \eqn{depth}. More precisely, the number of terminal nodes has the formulation of \deqn{m^depth}. For instance, if \eqn{m} is 2 and \eqn{depth} is 3, then the number of terminal nodes are \eqn{2^3} i.e. 8.
#' @return A dataframe.
#' @seealso [buildHierarchy()] to build hierarchical data.

genTree <- function(m, depth)
{
  #initiate an empty tree with the required depth
  completeTree <- vector(mode = "list", length = depth)
  #add branches to the tree iteratively
  for(d in depth:1)
  {
    #compute number of terminal vertices for that depth. Since this is complete m-ary tree, the number of terminal vertices takes the form of number of children per branch raised to the power of number of levels
    numOfVertices <- m^d
    #generate named terminal vertices for that depth
    vertices <- buildName(numOfVertices, paste("Level", d,"element","",sep="_"))
    #store the vertices at that level of the tree
    completeTree[[d]] <- vertices
  }

  #steps to map branches to sub branches
  #extract each level of list into seperate list
  for(i in seq_along(completeTree))
  {
    l <- unlist(completeTree[i])
    assign(paste('level',i,sep = ''),l)
  }

  #source all the individual lists. Since the lists are dynamic i.e., their number depends on the m and depth, strings are generated and parsed as arguments of a function.
  levelNames <- buildName(depth, 'level')
  levelNames <- paste(as.character(levelNames), collapse=", ")

  #cbind all the lists into once dataframe
  args <- as.list(parse(text=paste0("f(", levelNames , ")"))[[1]])[-1]
  outDf <- do.call(treeDf,args)

  return(outDf)
}

