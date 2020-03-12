#' @title Build Outliers in Data Distribution
#' @description Builds outlier values and replaces random data points with outliers. This is an internal function and is currently not exported in the package.
#' @param distr numeric vector. This is the target vector which is processed for outlier generation.
#' @details It is a common occurrence to have outliers in production data. For instance, in the retail industry, there are days such as black Friday where the sales for that day are far more than the daily average for the year. For the synthetic data generated to seem similar to production data, package conjurer uses this function to build such outlier data.
#'
#'This function takes a numeric vector and then randomly selects at least 1 data point and a maximum of 3 percent data points to be replaced with an outlier. The process for generating outliers is as follows. This methodology of outlier generation is based on a popular method of identifying outliers. For more details refer to the function 'outlier' in R package 'GmAMisc'.
#'\enumerate{
#'\item First, the interquartile range(IQR) of the numeric vector is computed.
#'\item Second, a random number between 1.5 and 3 is generated.
#'\item Finally, the random number above is multiplied with the IQR to compute the outlier.
#'
#'These steps mentioned above are repeated for at least once and a maximum of 3% of the input vector length. After the outlier values are generated, they are used to replace randomly selected values from the input vector.
#'}
#'
#' @return A numeric vector with random values replaced with outlier values.
buildOutliers <- function(distr)
{
  #compute the inter quartile range
  q1 <- summary(distr)[[2]]
  q3 <- summary(distr)[[5]]
  iqr <- (q3-q1)

  #compute the number of outliers needed. It is atleast 1 and atmost 3% of the distribution size
  numOfOutliers <- max(0.03 * length(distr),1)

  #compute the outliers by selecting the weight randomly.
  outlierWts <- sample(seq(1.5, 3, by = 0.01),numOfOutliers)
  outliers <- (outlierWts * iqr)

  #replace randomly selected values with outlier values
  selectedVals <- (sample(distr, numOfOutliers))
  distr[distr %in% selectedVals] <- outliers[match(distr, selectedVals, nomatch = 0)]
  return(distr)
}
