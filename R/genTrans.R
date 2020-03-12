#' Build Transaction Data
#' @param cycles This represents the cyclicality of data. It can take the following values
#' \enumerate{
#' \item "y". If cycles is set to the value "y", it means that there is only one instance of a high number of transactions during the entire year. This is a very common situation for some retail clients where the highest number of sales are during the holiday period in December.
#'\item "q". If cycles is set to the value "q", it means that there are 4 instances of a high number of transactions. This is generally noticed in the financial services industry where the financial statements are revised every quarter and have an impact on the equity transactions in the secondary market.
#'\item "m". If cycles is set to the value "m", it means that there are 12 instances of a high number of transactions for a year. This means that the number of transactions increases once every month and then subside for the rest of the month.
#' }
#' @param trend A number. This represents the slope of data distribution. It can take a value of 1 or -1. If the trend is set to value 1, then the aggregated monthly transactions will exhibit an upward trend from January to December and vice versa if it is set to -1.
#' @param outliers A number. This signifies the presence of outliers. If set to value 1, then outliers are generated randomly. If set to value 0, then no outliers are generated. The presence of outliers is a very common occurrence and hence setting the outliers to 1 is recommended. However, there are instances where outliers are not needed. For example, if the objective of data generation is solely for visualization purposes then outliers may not be needed.
#' @param transactions A number. This represents the number of transactions to be generated.
#' @param spike A number. This represents the seasonality of data. It can take any value from 1 to 12. These numbers represent months in a year, from January to December respectively. For example, if the spike is set to 12, it means that December has the highest number of transactions.
#' @return A dataframe with day number and count of transactions on that day
#' @examples
#' df <- genTrans(cycles = "y", trend = 1, transactions = 10000, spike = 10, outliers = 0)
#' df <- genTrans(cycles = "q", trend = -1, transactions = 32000, spike = 12, outliers = 1)

#' @export
#function to build transactions. Insights are work in progress
genTrans <- function(cycles, trend, transactions, spike, outliers)
{
  #handle missing arguments
  cycles <- missingArgHandler(cycles,"y")
  trend <- missingArgHandler(trend,1)
  transactions <- missingArgHandler(transactions,10000)
  outliers <- missingArgHandler(outliers, 1)

  #Exception handling.
  if(transactions <= 0)
  {
    stop("Please enter non zero positive integers")
  }else if(transactions < 10000)
  {
    warning("Insights may not be meaningful. Recommended number of transactions for meaningful insights is 10,000.")
  }

  if(spike > 12 | spike < 1)
  {
    stop("Please set spike between 1 and 12")
  }

  if(trend == 1 | trend == -1)
  {

  }else
  {
    stop("Please set trend as 1 or -1")
  }

  if(outliers == 1 | outliers == 0)
  {

  }else
  {
    stop("Please set outliers as 1 or 0")
  }

  #compute weights for 12 months
  if(missing(spike))
  {
    aggDataMth <- as.data.frame(buildDistr(cycles = cycles, trend = trend))
  }else
  {
    distr <- buildDistr(cycles = cycles, trend = trend)
    distrspiked <- buildSpike(distr = distr, spike = spike)
    aggDataMth <- as.data.frame(distrspiked)
  }

  colnames(aggDataMth) <- c('distrWt')
  wts <- (transactions/sum(aggDataMth$distrWt))
  aggDataMth$weights <- (aggDataMth$distrWt*wts)
  aggDataMth$mth <- row.names(aggDataMth)
  daysInMth <- data.frame(matrix(nrow = 12, ncol = 1))
  aggDataMth$days <- c(31 ,28 ,31 ,30 ,31 ,30 ,31 ,31 ,30 ,31 ,30 ,31)

  #compute weights for 4 weeks each month
  for(i in seq_len(nrow(aggDataMth)))
  {
    aggDataDayTemp <- as.data.frame(buildDistr(st = 1, en = (aggDataMth$days[i]), cycles = "y", trend = trend))
    colnames(aggDataDayTemp) <- c('distrWtWk')
    wts <- (aggDataMth$weights[i]/sum(aggDataDayTemp$distrWtWk))
    aggDataDayTemp$weights <- (aggDataDayTemp$distrWtWk*wts)
    aggDataDayTemp$mth <- aggDataMth$mth[i]

    if(i == 1)
    {
      aggDataDay <- aggDataDayTemp
    }else

      aggDataDay <- rbind(aggDataDay, aggDataDayTemp)
  }

  aggDataDay$transactions <- round(aggDataDay$weights)
  aggDataDay$day <- seq_len(nrow(aggDataDay))


  #add outliers
  if(outliers == 1)
  {
    aggDataDay$transactions <- (buildOutliers(aggDataDay$transactions))
  }else if(outliers == 0)
  {
    aggDataDay <- aggDataDay
  }

  aggDataDay$transactions <- round(aggDataDay$transactions, 0)

  #build dataframe at transaction level
  dfFinal <- data.frame()#build empty df
  for(i in seq_len(nrow(aggDataDay)))
  {
    numOfTrans <- aggDataDay$transactions[i]
    dayNum <- aggDataDay$day[i]
    mthNum <- aggDataDay$mth[i]
    temp <- as.data.frame(buildName(numOfItems = numOfTrans, prefix = paste("txn","-",i,"-",sep = "")))
    names(temp) <- c("transactionID")
    temp$dayNum <- dayNum
    temp$mthNum <- mthNum
    dfFinal <- rbind(dfFinal, temp)
  }
  return(dfFinal)
}
