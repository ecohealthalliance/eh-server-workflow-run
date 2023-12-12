# long_running_script.R
library(checkpoint)

# Function to perform a long-running task
long_running_task <- function(start_point) {
  result = start_point
  for (i in start_point:(start_point + 100000)) {
    # Simulate some computation
    result = result + i
    # Save checkpoint every 1000 iterations
    if (i %% 1000 == 0) {
      saveRDS(result, file = "checkpoint.rds")
    }
  }
  return(result)
}

# Check if a checkpoint exists
if (file.exists("checkpoint.rds")) {
  start_point <- readRDS("checkpoint.rds")
} else {
  start_point <- 1
}

# Run the task
final_result <- long_running_task(start_point)
saveRDS(final_result, file = "final_result.rds")
