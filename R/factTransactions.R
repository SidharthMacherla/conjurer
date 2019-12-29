#' Build Transaction Data
#' @param cycles A string.
#' @param trend A number. The value is either 1 or -1. Value 1 signifies upward trend and value -1 signifies downward trend.
#' @param outliers A number. The value is either 1 or 0. Value 1 builds outliers and value 0 does not build outliers.
#' @param transactions A number.
#' @param spike A number. This defines the month where the data distribution has the highest value. The number ranges from 1 to 12 representing the 12 months in the order of January to December.
#' @return A dataframe with day number and count of transactions on that day
#' @examples
#' df <- genTrans(cycles = "y", trend = 1, transactions = 10000, spike = 10, outliers = 0)
#' df <- genTrans(cycles = "q", trend = -1, transactions = 32000, spike = 12, outliers = 1)

#' @export
#function to build transactions. Insights are work in progress
genTrans <- function(cycles, trend, transactions, spike, outliers)
{
  #handle missing arguments
  cycles <- missingArgHandler(cycles,"y");
  trend <- missingArgHandler(trend,1);
  transactions <- missingArgHandler(transactions,10000);
  outliers <- missingArgHandler(outliers, 1);

  #Exception handling.
  if(transactions <= 0)
  {
    stop("Please enter non zero positive integers");
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
    stop("Please set trend as 1 or -1");
  }

  if(outliers == 1 | outliers == 0)
  {

  }else
  {
    stop("Please set outliers as 1 or 0");
  }

  #compute weights for 12 months
  if(missing(spike))
  {
    aggDataMth <- as.data.frame(buildDistr(cycles = cycles, trend = trend));
  }else
  {
    distr <- buildDistr(cycles = cycles, trend = trend);
    distrspiked <- buildSpike(distr = distr, spike = spike);
    aggDataMth <- as.data.frame(distrspiked);
  }

  colnames(aggDataMth) <- c('distrWt');
  wts <- (transactions/sum(aggDataMth$distrWt));
  aggDataMth$weights <- (aggDataMth$distrWt*wts);
  aggDataMth$mth <- row.names(aggDataMth);
  daysInMth <- data.frame(matrix(nrow = 12, ncol = 1))
  aggDataMth$days <- c(31 ,28 ,31 ,30 ,31 ,30 ,31 ,31 ,30 ,31 ,30 ,31);

  #compute weights for 4 weeks each month
  for(i in 1:nrow(aggDataMth))
  {
    aggDataDayTemp <- as.data.frame(buildDistr(st = 1, en = (aggDataMth$days[i]), cycles = "y", trend = trend));
    colnames(aggDataDayTemp) <- c('distrWtWk')
    wts <- (aggDataMth$weights[i]/sum(aggDataDayTemp$distrWtWk));
    aggDataDayTemp$weights <- (aggDataDayTemp$distrWtWk*wts);
    aggDataDayTemp$mth <- aggDataMth$mth[i];

    if(i == 1)
    {
      aggDataDay <- aggDataDayTemp;
    }else
    {
      aggDataDay <- rbind(aggDataDay, aggDataDayTemp);
    }
  }
  aggDataDay$transactions <- round(aggDataDay$weights);
  aggDataDay$day <- 1:nrow(aggDataDay);


  #add outliers
  if(outliers == 1)
  {
    aggDataDay$transactions <- (buildOutliers(aggDataDay$transactions));
  }else if(outliers == 0)
  {
    aggDataDay <- aggDataDay;
  }

  return(aggDataDay[,c('day', 'transactions')])
}
