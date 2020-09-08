#' Build Numeric Data
#' @param n A number. This specifies the number of values to be generated.
#' @param st A number. This defines the starting value of the number of data points.
#' @param en A number. This defines the ending value of the number of data points.
#' @param disp A number between \eqn{-(pi/2)} and  \eqn{(pi/2)}. This defines the dispersion of the distribution.
#' @param outliers A number. This signifies the presence of outliers. If set to value 1, then outliers are generated randomly. If set to value 0, then no outliers are generated. The presence of outliers is a very common occurrence and hence setting the outliers to 1 is recommended. However, there are instances where outliers are not needed. For example, if the objective of data generation is solely for visualization purposes then outliers may not be needed.
#' @return A dataframe
#' @details This function helps in generating numeric data such as age, height, weight etc. This function could be used along with other functions such as \code{\link{buildCust}} to make it more meaningful. The data distribution function uses the formulation of
#' \deqn{sin((r*a)*x) + c}
#' Where,
#' \enumerate{
#' \item r is the random value such that \eqn{0.8 <= r <= 1.2}. This adds \eqn{+/-} 20\% randomness to the parameter \eqn{a}.
#' \item a is the parameter such that, \eqn{-(pi/2) <= a <= (pi/2)}.
#' \item x is a variable such that,  \eqn{(pi/2) <= x <= (pi/2)}.
#' \item c is a constant such that \eqn{2 <= c <= 5}.
#' }
#'
#'The key component of this function is \eqn{disp}. This helps in controlling the dispersion of the distribution. Let us assume that one would like to generate age of people in years. Furthermore, let us assume that the range of the age is between 23 and 80. If \eqn{disp = 1}, then the function will generate more data with a negative slope i.e more people with age closer to 23 than 80. If \eqn{disp = 1} is used, then the opposite will be true. However, if one would like to generate data that is visually similar to normal distribution i.e more people in the middle age group and less towards 23 or 80, then \eqn{disp = 0.5} could be used.
#'
#'It is recommended to firstly plot the code and inspect visually to check which distribution is needed.
#'
#' @examples
#' age <- buildNum(n = 10, st = 23, en = 80, disp = 0.5, outliers = 1)
#' plot(age) #visualize the resulting distribution

#' @export

buildNum <- function(n, st, en, disp, outliers)
{
  #handle missing arguments
  outliers <- missingArgHandler(outliers, 1)
  disp <- missingArgHandler(disp, 1)

  #Exception handling for n
  if(missing(n))
  {
    stop("'n' is missing. Please specify the number of values to generate")
  }else if(n < 10)
  {
    warning("'n' is too small. Recommended 'n' value is atleast 10.")
  }
  #Ensure that 'n' is a whole number
  if((n)%%1 != 0)
  {
    warning(sprintf("'n' must be a whole number. Note that %s is rounded off to %s.", n, round(n)))
  }


  #Exception handling for disp
  if(disp < -(pi/2) | disp > (pi/2))
  {
    stop("The value of 'disp' must be between -(pi/2) and (pi/2)")
  }

  #Build distributions by calling internal function buildDistr
  distr <- buildDistr(st = st, en = en, cycles = "n", trend = disp, n = n)

  #Add outliers
  if(outliers == 1)
  {
    distr <- (buildOutliers(distr))
  }else if(outliers == 0)
  {
    distr <- distr
  }

  return(distr)
}
