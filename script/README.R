"The data is taken from the ISLR library"
library(ISLR)
caravan <- Caravan

names(Caravan)

"Oh my goodness i don't know what these variables represent. Ok so the first 85
variables are demografic information about a customer. The last variable, that
is Purchase indicates whether the person purchase insurance from this company
or not."

"Checking for NAs"

any(is.na(caravan))
"Oh there is no NA at all."