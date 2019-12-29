#' @title Build Product Data
#' @description Builds unique product identifier and price. The price of the product is generated randomly within the minimum and the maximum range provided as input.
#' @param numOfProd A number. This defines the number of unique products.
#' @param minPrice A number. This defines the lower threshold of the product price.
#' @param maxPrice A number. This defines the lower threshold of the product price.
#' @return A character with product identifier and price.
#' @examples
#' df <- buildProd(numOfProd = 1000, minPrice = 5, maxPrice = 100)
#' df <- buildProd(numOfProd = 29, minPrice = 3, maxPrice = 50)

#' @export
buildProd <- function(numOfProd, minPrice, maxPrice)
{
  prodId <- as.data.frame(buildName(numOfItems = numOfProd, prefix = "sku"));
  prodPrice <- sample(seq(minPrice,maxPrice,by = 0.01), size = numOfProd,replace = FALSE);
  prod <- data.frame(prodId,prodPrice)
  colnames(prod) <- c("SKU", "Price");
  return(prod)
}




