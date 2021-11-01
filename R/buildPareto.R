#' @title Map Factors Based on Pareto Arguments
#' @description Maps a factor to another factor in a one to many relationship following Pareto principle. For example, 80 percent of transactions can be mapped to 20 percent of customers.
#' @param factor1 A factor. This factor is mapped to factor2 as given in the details section.
#' @param factor2 A factor. This factor is mapped to factor1 as given in the details section.
#' @param pareto This defines the percentage allocation and is a numeric data type. This argument takes the form of c(x,y) where x and y are numeric and their sum is 100. If we set Pareto to c(80,20), it then allocates 80 percent of factor1 to 20 percent of factor 2. This is based on a well-known concept of the Pareto principle.
#' @details This function is used to map one factor to another based on the Pareto argument supplied. If factor1 is a factor of customer identifiers, factor2 is a factor of transactions and Pareto is set to c(80,20), then 80 percent of customer identifiers will be mapped to 20 percent of transactions and vice versa.
#' @return A data frame with factor 1 and factor 2 as columns. Based on the Pareto arguments passed, column factor 1 is mapped to factor 2.
#' @example
#' customers <- LETTERS[seq( from = 1, to = 10 )]
#' products <- seq(1:100)
#' df <- buildPareto(factor1 = customers, factor2 = products)

#' @export
buildPareto <- function(factor1, factor2, pareto)
{
  #Exception handling.
  paretoTotal <- (pareto[1]+pareto[2])
  if(paretoTotal != 100)
  {
    stop("Pareto values must add up to 100. For example, pareto = c(80,20)")
  }

  #randomise the sequence of the factors
  factor1Shuffled <- sample(factor1)
  factor2Shuffled <- sample(factor2)

  #format the split thresholds
  split1 <- pareto[1]*0.01
  split2 <- pareto[2]*0.01

  #split factor1 by the given split
  factor1sample1 <- sample.int(n = length(factor1Shuffled), size = floor(split1*length(factor1Shuffled)), replace = FALSE)
  factor1p1 <- factor1Shuffled[factor1sample1]
  factor1p2 <- factor1Shuffled[-factor1sample1]

  #split factor2 by the given split
  factor2sample1 <- sample.int(n = length(factor2Shuffled), size = floor(split1*length(factor2Shuffled)), replace = FALSE)
  factor2p1 <- factor2Shuffled[factor2sample1]
  factor2p2 <- factor2Shuffled[-factor2sample1]

  #map the factors based on the thresholds. map 80 to 20 and then 20 to 80
  map1 <- sample(factor1p2, size = length(factor2p1), replace = TRUE,prob = NULL)
  dfMap1 <- data.frame(factor2p1, map1)
  names(dfMap1) <- c("factor2","factor1")

  map2 <- sample(factor1p1, size = length(factor2p2), replace = TRUE,prob = NULL)
  dfMap2 <- data.frame(factor2p2, map2)
  names(dfMap2) <- c("factor2","factor1")

  #build the final dataframe
  dfMapFinal <- rbind(dfMap1, dfMap2)

  return(dfMapFinal)
}
