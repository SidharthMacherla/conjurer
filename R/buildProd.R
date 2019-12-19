#' Build Product Data
#' @param numOfProd A number.
#' @param minPrice A number.
#' @param maxPrice A number.
#' @return A character with product identifier and price
#' @examples
#' df <- buildProd(1000, 5, 100)
#' df <- buildProd(29,3,50)

#' @export
buildProd <- function(numOfProd, minPrice, maxPrice)
{
  prodId <- as.data.frame(buildName(numOfItems = numOfProd, prefix = "sku"));
  prodPrice <- sample(seq(minPrice,maxPrice,by = 0.01), size = numOfProd,replace = FALSE);
  prod <- data.frame(prodId,prodPrice)
  colnames(prod) <- c("SKU", "Price");
  return(prod)
}




