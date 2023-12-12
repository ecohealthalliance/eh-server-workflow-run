#!/bin/bash
#SBATCH --job-name=memory_intensive_job  # Job name
#SBATCH --output=memory_intensive_res.txt # Standard output and error log
#SBATCH --ntasks=1                       # Run a single task
#SBATCH --cpus-per-task=4                # Number of CPU cores per task
#SBATCH --time=04:00:00                  # Time limit hrs:min:sec
#SBATCH --mem=32G                        # Memory needed

                           # Load R module (adjust if necessary)
Rscript memory_intensive_script.R        # Run the R script
