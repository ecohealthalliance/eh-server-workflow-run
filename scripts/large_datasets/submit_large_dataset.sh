#!/bin/bash
#SBATCH --job-name=large_dataset_job  # Job name
#SBATCH --output=large_dataset_res.txt # Standard output and error log
#SBATCH --time=02:00:00               # Time limit hrs:min:sec (optional)
#SBATCH --mem=32G                     # Memory needed (adjust as required)

                     # Load R module (adjust if necessary)
Rscript large_dataset_script.R        # Run the R script
