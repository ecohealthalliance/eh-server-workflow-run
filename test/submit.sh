#!/bin/bash
#SBATCH --job-name=test    # Job name
#SBATCH --output=~/eh-server-workflow-run/test/large_dataset_res.txt   # Standard output and error log
#SBATCH --error=~/eh-server-workflow-run/test/large_dataset_res.txt    # Redirect standard error to the same file
#SBATCH --time=02:00:00                  # Time limit hrs:min:sec (optional)
#SBATCH --mem=25G                 # Memory needed (adjust as required)
#SBATCH --partition=all



# Run the R scri
/usr/local/bin/Rscript ~/eh-server-workflow-run/test/test.R


# Use sacct to get resource usage and append it to a file
sacct -j $SLURM_JOB_ID --format=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> ~/eh-server-workflow-run/test/resource_usage.txt