#' Build Transaction Data
#' @param cycles A string.
#' @param trend A number.
#' @param transactions A number.
#' @return A dataframe with day number and count of transactions on that day
#' @examples
#' df <- genTrans("y", 1,10000)
#' df <- genTrans("q", -1,32000)

#' @export
#function to build transactions. Insights are work in progress
genTrans <- function(cycles, trend, transactions)
{
  #handle missing arguments
  cycles <- missingArgHandler(cycles,"y");
  trend <- missingArgHandler(trend,1);
  transactions <- missingArgHandler(transactions,10000);

  #Exception handling.
  if(transactions <= 0)
  {
    stop("Please enter non zero positive integers");
  }else if(transactions < 10000)
  {
    warning("Insights may not be meaningful. Recommended number of transactions for meaningful insights is 10,000.")
  }

  #compute weights for 12 months
  aggDataMth <- as.data.frame(buildDistr(cycles = cycles, trend = trend));
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

  return(aggDataDay[,c('day', 'transactions')])
}
