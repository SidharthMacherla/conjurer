#' @title Build Spikes in the Data Distribution
#' @description Builds spikes in the data distribution. For example, in retail industry transactions are generally higher during the holiday season such as December. This function is used to set the same.
#' @param distr numeric vector. This is the input vector for which the spike value needs to be set.
#' @param spike A number. This represents the seasonality of data. It can take any value from 1 to 12. These numbers represent months in a year, from January to December respectively. For example, if the spike is set to 12, it means that December has the highest number of transactions. This is an internal function and is currently not exported in the package.
#' @return A numeric vector reordered
buildSpike <- function(distr, spike)
{
  distrDf <- as.data.frame(distr)
  names(distrDf) <- c("wt")
  distrDf$mth <- as.numeric(row.names(distrDf))
  maxVal <- max(distr)
  maxValIndex <- as.numeric(row.names(distrDf[distrDf$wt==maxVal,]))
  spikeMinusMaxvalindex <- (spike - maxValIndex)
  distrDf$mthTemp <- (distrDf$mth + spikeMinusMaxvalindex)
  distrDf$mthFinal <- ifelse(distrDf$mthTemp>12,(distrDf$mthTemp-12),distrDf$mthTemp)
  distrDf <- distrDf[order(distrDf$mthFinal), ]
  distrOut <- distrDf$wt
  return(distrOut)
}
