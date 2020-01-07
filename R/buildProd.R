#' @title Build Product Data
#' @description Builds a unique product identifier and price. The price of the product is generated randomly within the minimum and the maximum range provided as input.
#' @param numOfProd A number. This defines the number of unique products.
#' @param minPrice A number. This is the minimum value of the product's price range.
#' @param maxPrice A number. This is the maximum value of the product's price range.
#' @details A product ID is alphanumeric with prefix "sku" which signifies a stock keeping unit. This prefix is followed by a numeric ranging from 1 and extending to the number of products provided as the argument within the function. For example, if there are 10 products, then the product ID will range from sku01 to sku10. This ensures that the product ID is always of the same length. For these product IDs, the product price will be within the range of minPrice and maxPrice arguments.
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




