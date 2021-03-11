"The data is taken from the ISLR library"
library(ISLR)
caravan <- Caravan

#Normalizing the data
mean <- c()
for (i in 1:85) {
  mean <- c(mean, mean(caravan[,i]))
}

sd <- c()
for (i in 1:85) {
  sd <- c(sd, sd(caravan[,i]))
}

normal_caravan <- data.frame(matrix(nrow = 5822, ncol = 85))
for (j in 1:85) {
  for (i in 1:5822){
    normal_caravan[i,j] <- (caravan[i,j] - mean[j]) / sd[j]
  }
}  
rm(i,j, mean, sd)

names(normal_caravan) <- names(caravan)[1:85]

"Checking the data frame"
sapply(normal_caravan, var) # all of them is 1
sapply(normal_caravan, mean) # all of them very close to 0

"We successfully get our normalized data frame. We could do this easily with
the scale function."

normalized_caravan <- scale(caravan[,-86])
"The result is a matrix with exactly the same values with our data frame."
