#!/bin/bash
#SBATCH --job-name=simple_job       # Job name
#SBATCH --output=res.txt            # Standard output and error log
#SBATCH --time=01:00:00             # Time limit hrs:min:sec (optional)
#SBATCH --mem=1000                  # Memory needed per node (optional)

                     
Rscript simple_script.R            # Run the R script
