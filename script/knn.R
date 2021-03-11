"The data is taken from the ISLR library"
library(ISLR)
caravan <- Caravan

"The data is normalized."
normalized_caravan <- data.frame(scale(caravan[,-86]))

"Splitting the data into training and test data"
library(caTools)
set.seed(1001)
sample <- sample.split(normalized_caravan$MOSTYPE, 0.7)

train <- normalized_caravan[sample,]
test <- normalized_caravan[!sample,]

train.Purchase <- caravan[sample,]$Purchase
test.Purchase <- caravan[!sample,]$Purchase
rm(sample)

#Finding the best k
library(class)
predicted <- NULL
error <- NULL

for (i in 1:20) {
  predicted <- knn(train, test, train.Purchase, k = i)
  error[i] <- mean(predicted != test.Purchase)
}

error

"We can see that our error continue to decrease as we increase k all from 1 to
10. But after that increasing k does not improve our accuracy. So we are going
to use k = 10."

"We can also plot our error rate with ggplot2"
library(ggplot2)
error.rate <- data.frame(k = 1:20, error)
ggplot(error.rate, aes(x = k, y = error)) +
  geom_point() +
  geom_line() +
  ggtitle("Error Rate by k for Seed = 1001 and Split Ratio = 0.7") +
  theme_bw()

rm(i, error, predicted, error.rate)

#Building the model
predicted <- knn(train, test, train.Purchase, k = 10) #The order is like this
result <- data.frame(cbind(test.Purchase, predicted))

rm(test, train, train.Purchase, predicted)
"No is 1 and Yes is 0"

"Building Confusion Matrix"
Confusion.Matrix <- matrix(nrow = 2, ncol = 2)
tn <- sum(result$test.Purchase == 1 & result$predicted == 1)
fp <- sum(result$test.Purchase == 1 & result$predicted == 2)
fn <- sum(result$test.Purchase == 2 & result$predicted == 1)
tp <- sum(result$test.Purchase == 2 & result$predicted == 2)

rm(test.Purchase)

Confusion.Matrix[1,1] <- tn
Confusion.Matrix[1,2] <- fp
Confusion.Matrix[2,1] <- fn
Confusion.Matrix[2,2] <- tp

#Finding accuracy
accuracy <- (tn + tp) / (tn + tp + fn + fp)
rm(tn, tp, fp, fn)

"The model has 94.3% accuracy. From the confusion matrix we know that the model
is really good to predict those who won't purchase. But struggles at predicting
those who actually make a purchase. We can see the actual probability in the
following data frame."

Predicted <- c("No", "No", "Yes", "Yes")
Actual <- c("No", "Yes", "No", "Yes")
Probability <- c(1647/(1647+97),
                 1 - 1647/(1647+97),
                 1/(1+1),
                 1 - 1/(1+1))
Probability.Matrix <- data.frame(cbind(Predicted, Actual, Probability))
rm(Predicted, Actual, Probability)