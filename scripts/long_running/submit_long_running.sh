#!/bin/bash
#SBATCH --job-name=long_running_job  # Job name
#SBATCH --output=long_running_res.txt # Standard output and error log
#SBATCH --time=24:00:00              # Time limit 24 hours
#SBATCH --mem=4G                     # Memory needed (adjust as required)
                      
                      
Rscript long_running_script.R        # Run the R script
