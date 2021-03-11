"The data is taken from the ISLR library"
library(ISLR)
caravan <- Caravan

"We want to know how many people actually purchase the insurance."

sum(caravan$Purchase == "Yes")

"So only 348 people purchase the insurance (6% of 5822). The proportion is so
small it must be hard to be an insurance agent."