# large_dataset_script.R
library(data.table)

# Assume 'large_dataset.csv' is a large file
input_file <- "large_dataset.csv"
output_file <- "processed_dataset.csv"

# Read the large dataset
dt <- fread(input_file)

# Example operation: Filtering and aggregating data
processed_dt <- dt[variable1 > threshold, .(Mean = mean(variable2)), by = .(groupVariable)]

# Write the processed data to a file
fwrite(processed_dt, output_file)
