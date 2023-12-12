#!/bin/bash
#SBATCH --job-name=parallel_job     # Job name
#SBATCH --output=parallel_res.txt   # Standard output and error log
#SBATCH --ntasks=1                  # Run a single task
#SBATCH --cpus-per-task=4           # Number of CPU cores per task
#SBATCH --time=01:00:00             # Time limit hrs:min:sec (optional)
#SBATCH --mem=2000                  # Memory needed (optional)

                

# Run the R script
/usr/local/bin/Rscript   parallel_script.R



# Use sacct to get resource usage and append it to a fileormat=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> ~/eh-server-workflow-run/test/resource_usage.txt


sacct -j $SLURM_JOB_ID --format=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> resource_usage.txt