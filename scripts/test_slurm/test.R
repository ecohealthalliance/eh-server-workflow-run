# Load the 'dplyr' package
library(dplyr)

# Perform a simple data manipulation with 'dplyr'
data <- data.frame(x = 1:10, y = 11:20)
result <- data %>% mutate(z = x + y)

# Save the result to a file
write.csv(result, file = "results.csv")

# Print a message indicating the completion of the computation
cat("Computation completed. Result saved to 'results.csv'.\n")
