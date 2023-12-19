# Function to calculate mode
get_mode <- function(v) {
  uniq_v <- unique(v)
  uniq_v[which.max(tabulate(match(v, uniq_v)))]
}

# Generate a large list of random numbers
set.seed(123)  # Set seed for reproducibility
numbers <- runif(1e7, 1, 100)  # 10 million random numbers between 1 and 100

# Simulate a computationally intensive task
# Calculate a complex function for each number (e.g., logarithm)
log_numbers <- log(numbers)

# Calculate statistics
mean_val <- mean(numbers)
variance_val <- var(numbers)
mode_val <- get_mode(numbers)
sum_val <- sum(numbers)
complex_mean_val <- mean(log_numbers)  # Mean of the complex function results

# Prepare output
output <- paste(
  "Mean: ", mean_val, "\n",
  "Variance: ", variance_val, "\n",
  "Mode: ", mode_val, "\n",
  "Sum: ", sum_val, "\n",
  "Complex Mean of Logarithms: ", complex_mean_val, "\n",
  sep = ""
)

# Optionally, you can include some delay
Sys.sleep(10)  # Sleep for 10 seconds

# Write output to a file
write(output, file = "statistics_results.txt")


# Write output to a file
write(output, file = "~/eh-server-workflow-run/test/statistics_results.txt")