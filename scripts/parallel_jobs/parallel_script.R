# parallel_script.R
library(parallel)

# Define a function to be run in parallel
myFunction <- function(id) {
  Sys.sleep(5)  # Simulates some computation
  return(paste("Processed by", id))
}

# Detect the number of cores available
no_cores <- detectCores()

# Run the function in parallel
results <- mclapply(1:no_cores, myFunction, mc.cores = no_cores)

# Print the results
print(results)
