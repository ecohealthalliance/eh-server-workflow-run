#!/bin/bash
#SBATCH --job-name=test    # Job name
#SBATCH --output=large_dataset_res.txt   # Standard output and error log
#SBATCH --error=large_dataset_res.txt    # Redirect standard error to the same file
#SBATCH --time=02:00:00                  # Time limit hrs:min:sec (optional)
#SBATCH --mem=25G                 # Memory needed (adjust as required)
#SBATCH --partition=all



# Run the R script
Rscript  large_dataset.R 


# Wait for this job to finish
wait

# Use sacct to get resource usage and append it to a file
sacct -j $SLURM_JOB_ID --format=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> ~/eh-server-workflow-run/scripts/large_datasets/resource_usage.txt