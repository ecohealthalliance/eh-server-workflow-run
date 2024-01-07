#!/bin/bash
#SBATCH --job-name=tes_job    # Job name
#SBATCH --output=large_dataset_res.txt   # Standard output and error log
#SBATCH --error=large_dataset_res.txt    # Redirect standard error to the same file
#SBATCH --time=00:04:00                  # Time limit hrs:min:sec (optional)
#SBATCH --mem=25G                 # Memory needed (adjust as required)
#SBATCH --partition=gpu



# Run the R script
Rscript   simple_script.R



# Use sacct to get resource usage and append it to a fileormat=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> ~/eh-server-workflow-run/test/resource_usage.txt


format=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> resource_usage.txt