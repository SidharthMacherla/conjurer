#' @title Build Data Distribution
#' @description Builds data distribution. For example, the function \code{\link{genTrans}} uses this function to build the data distributions necessary. This function uses trigonometry based functions to generate data. This is an internal function and is currently not exported in the package.
#' @param st A number. This defines the starting value of the number of data points.
#' @param en A number. This defines the ending value of the number of data points.
#' @param cycles A string. This defines the cyclicality of data distribution.
#' @param trend A number. This defines the trend of data distribution i.e if the data has a positive slope or a negative slope.
#' @param n A numeric. This specifies the number of values to be generated. It should be non-zero natural number. This parameter is currently used by the function \code{\link{buildNum}}.
#' @details A parametric method is used to build data distribution. The data distribution function uses the formulation of
#' \deqn{sin(a*x) + cos(b*x) + c}
#' Where,
#' \enumerate{
#' \item a and b are the parameters
#' \item x is a variable
#' \item c is a constant
#' }
#'Firstly, parameter 'a' defines the number of outer level crests (peaks in the data distribution). Generally speaking, the number of crests is approximately twice the value of a. This means that if a is set to a value 0.5, there will be one crest and if it is set to 2, there will be 4 crests. On account of this behavior, this parameter is set based on the argument cycles of the function. For example, if the argument cycles is set to "y" i.e yearly cycle, it means that there must be one crest i.e peak in the distribution. To have one crest, the parameter must be around 0.5. A random number is then generated between 0.2 and 0.6 to get to that one crest.
#'
#'Secondly, the variable 'x' is the x-axis of the data distribution. Since the function  \code{\link{buildDistr}} is used internally to generate data at different levels, this variable could have a range of 1 to 12 or 1 to 31 depending on the arguments 'st' and 'en'. For example, if the data is generated at the month level, then arguments 'st' is set to 1 and 'en' is set to 12. Similarly, if the data is set to day level, the 'st' is set to 1 and 'en' is set to the number of days in that month i.e 28 for month 2 and 31 for month 12 etc.
#'
#'Thirdly, the parameter 'b' defines the inner level crests(peaks in data distribution). This parameter helps in making the data distribution seem more realistic by adding more "ruggedness" of the distribution.
#'
#'Finally, the constant 'c' is the intercept part of the formulation and primarily serves as a way to ensure that the data distribution has a positive 'y' axis component. This value is randomly generated between 2 and 5.
#' @return A data frame with data distribution is returned.
buildDistr <- function(st, en, cycles, trend, n)
{
  #handle missing arguments
  st <- missingArgHandler(st,1)
  en <- missingArgHandler(en,12)
  cycles <- missingArgHandler(cycles, "y")
  trend <- missingArgHandler(trend, 1)
  n <- missingArgHandler(n,100)

  if(cycles == "y")
  {
    a <- sample(seq(0.2, 0.5, by = 0.25),1)
    b <- sample(seq(0.2, 0.5, by = 0.25),1)
  }else if(cycles == "q")
  {
    a <- 2
    b <- sample(seq(0.5, 2.5, by = 0.25),1)
  }else if(cycles == "m")
  {
    a <- 3
    b <- 0.25
  }else if(cycles == "n") #Here, "n" is numeric. This is used to generate other distributions (continuous/discrete)
  {
    #randomize trend value within +- 20% range
    coeffs <- seq(from = 0.8, to =1.2, by =0.001)
    randomCoeff <- sample(coeffs, 1, replace = TRUE)
  }

  #generate intercept as a random int between 2 and 5
  c <- sample(2:5,1)
  x <- seq(st,en,by=(en-st)/(en-1))

  if(cycles == "n")
  {
    x <- seq(from = (pi/2), to = (3*pi/2), by = pi/(n-1))
    y <- sin((randomCoeff*trend)*x) + c
    percentY <- (y - min(y))/((max(y)-min(y)))
    distr <- ((en-st)*percentY)+st

  }else if(trend == 1 && cycles != "m")
  {
    distr <- sin(a*x) + cos(b*x) + c
  }else if(trend == 1 && cycles == "m")
  {
    distr <- sin(a*x) - cos(b*x) + c
  }else if(trend == -1 && cycles != "m")
  {
    distr <- sin(a*x) - cos(b*x) + c
  }else if(trend == -1 && cycles == "m")
  {
    distr <- sin(a*x) + cos(b*x) + c
  }
  return(distr)
}
