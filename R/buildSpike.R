#' @title Build Spikes in the Data Distribution
#' @description Builds spikes in the data distribution. For example, in retail industry transactions are generally higher during the holiday season such as December.
#' @param distr numeric.
#' @param spike A number. This defines the month where the data distribution has the highest value. The number ranges from 1 to 12 representing the 12 months in the order of January to December. This is an internal function and is currently not exported in the package.
#' @return A numeric vector reordered
buildSpike <- function(distr, spike)
{
  distrDf <- as.data.frame(distr);
  names(distrDf) <- c("wt");
  distrDf$mth <- as.numeric(row.names(distrDf));
  maxVal <- max(distr);
  maxValIndex <- as.numeric(row.names(distrDf[distrDf$wt==maxVal,]));
  spikeMinusMaxvalindex <- (spike - maxValIndex);
  distrDf$mthTemp <- (distrDf$mth + spikeMinusMaxvalindex);
  distrDf$mthFinal <- ifelse(distrDf$mthTemp>12,(distrDf$mthTemp-12),distrDf$mthTemp);
  distrDf <- distrDf[order(distrDf$mthFinal), ];
  distrOut <- distrDf$wt;
  return(distrOut);
}
