#' @title Build Data Distribution
#' @description Builds the distribution of data that is further used by other functions. For example, function 'genTrans' uses this function to build the data distributions necessary. This function uses trignometry based functions to generate data. This is an internal function and is currently not exported in the package.
#' @param st A number. This defines the starting value of the number of data points.
#' @param en A number. This defines the ending value of the number of data points.
#' @param cycles A string. This represents the cyclicality of the data distribution.
#' @param trend A number. This defines the trend of data distribution i.e if the data has a positive slope or a negative slope.
#' @return A dataframe with data distribution is returned.
buildDistr <- function(st, en, cycles, trend)
{
  #handle missing arguments
  st <- missingArgHandler(st,1);
  en <- missingArgHandler(en,12);
  cycles <- missingArgHandler(cycles, "y");

  if(cycles == "y")
  {
    a <- 0.5;
    b <- 0.5;
  }else if(cycles == "q")
  {
    a <- 2;
    b <- sample(seq(0.5, 2.5, by = 0.25),1);
  }else if(cycles == "m")
  {
    a <- 3;
    b <- 0.25;
  }

  #generate intercept as a random int between 2 and 5
  c <- sample(2:5,1);
  trend <- missingArgHandler(trend, 1);

  x <- seq(st,en,by=(en-st)/(en-1));
  if(trend == 1 && cycles != "m")
  {
    distr <- sin(a*x) + cos(b*x) + c;
  }else if(trend == 1 && cycles == "m")
  {
    distr <- sin(a*x) - cos(b*x) + c;
  }else if(trend == -1 && cycles != "m")
  {
    distr <- sin(a*x) - cos(b*x) + c;
  }else if(trend == -1 && cycles == "m")
  {
    distr <- sin(a*x) + cos(b*x) + c;
  }
  return(distr)
}
