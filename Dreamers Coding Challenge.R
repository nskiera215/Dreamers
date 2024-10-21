library(dplyr)
library(randomForest)
library(ranger)


sample <- read.csv("directional-forecasting-in-cryptocurrencies/sample_submission.csv")
train <- read.csv("directional-forecasting-in-cryptocurrencies/train.csv")
test <- read.csv("directional-forecasting-in-cryptocurrencies/test.csv")


new_train <- train %>%
  mutate(target = as.factor(target))

set.seed(100)
rf_mod <- ranger(target ~ ., data = new_train,
                 num.trees = 250
)


predictions <- predict(rf_mod, data = test[,-1], type = "response")$predictions

mean(predictions[1:50] == sample$target)