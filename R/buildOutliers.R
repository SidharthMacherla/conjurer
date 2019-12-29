#' @title Build Outliers in Data Distribution
#' @description Builds outlier values and replaces random data points with this outliers. This is an internal function and is currently not exported in the package.
#' @param distr numeric vector
#' @return A numeric vector with random values replaced with outlier values
buildOutliers <- function(distr)
{
  #compute the inter quartile range
  q1 <- summary(distr)[[2]];
  q3 <- summary(distr)[[5]];
  iqr <- (q3-q1);

  #compute the number of outliers needed. It is atleast 1 and atmost 3% of the distribution size
  numOfOutliers <- max(0.03 * length(distr),1);

  #compute the outliers by selecting the weight randomly.
  outlierWts <- sample(seq(1.5, 3, by = 0.01),numOfOutliers);
  outliers <- (outlierWts * iqr);

  #replace randomly selected values with outlier values
  selectedVals <- (sample(distr, numOfOutliers));
  distr[distr %in% selectedVals] <- outliers[match(distr, selectedVals, nomatch = 0)];
  return(distr);
}
