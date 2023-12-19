#!/bin/bash
#SBATCH --job-name=long_running_job  # Job name
#SBATCH --output=long_running_res.txt # Standard output and error log
#SBATCH --time=24:00:00              # Time limit 24 hours
#SBATCH --mem=4G                     # Memory needed (adjust as required)
                      
                      

# Run the R script
/usr/local/bin/Rscript   script_long_running.R



# Use sacct to get resource usage and append it to a fileormat=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> ~/eh-server-workflow-run/test/resource_usage.txt


sacct -j $SLURM_JOB_ID --format=JobID,JobName,Partition,MaxRSS,Elapsed,State,CPUTime,TotalCPU >> resource_usage.txt
