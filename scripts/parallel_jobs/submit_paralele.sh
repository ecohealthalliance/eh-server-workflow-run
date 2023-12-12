#!/bin/bash
#SBATCH --job-name=parallel_job     # Job name
#SBATCH --output=parallel_res.txt   # Standard output and error log
#SBATCH --ntasks=1                  # Run a single task
#SBATCH --cpus-per-task=4           # Number of CPU cores per task
#SBATCH --time=01:00:00             # Time limit hrs:min:sec (optional)
#SBATCH --mem=2000                  # Memory needed (optional)

                      # Load R module (adjust if necessary)
Rscript parallel_script.R           # Run the R script
