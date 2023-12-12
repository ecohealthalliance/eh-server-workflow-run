#!/bin/bash
#SBATCH --job-name=cpu_intensive_job  # Job name
#SBATCH --output=cpu_intensive_res.txt # Standard output and error log
#SBATCH --ntasks=1                    # Run a single task
#SBATCH --cpus-per-task=8             # Number of CPU cores per task
#SBATCH --time=02:00:00               # Time limit hrs:min:sec
#SBATCH --mem=4G                      # Memory needed


Rscript cpu_intensive_script.R        # Run the R script
