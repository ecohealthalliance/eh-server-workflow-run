# stats_calculator.R

# Function to calculate mode
get_mode <- function(v) {
  uniq_v <- unique(v)
  uniq_v[which.max(tabulate(match(v, uniq_v)))]
}

# Generate a list of random numbers
set.seed(123)  # Set seed for reproducibility
numbers <- runif(100, 1, 100)  # 100 random numbers between 1 and 100

# Calculate statistics
mean_val <- mean(numbers)
variance_val <- var(numbers)
mode_val <- get_mode(numbers)
sum_val <- sum(numbers)

# Prepare output
output <- paste(
  "Mean: ", mean_val, "\n",
  "Variance: ", variance_val, "\n",
  "Mode: ", mode_val, "\n",
  "Sum: ", sum_val, "\n",
  sep = ""
)

# Write output to a file
write(output, file = "~/eh-server-workflow-run/test/statistics_results.txt")
