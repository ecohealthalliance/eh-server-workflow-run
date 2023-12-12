#!/bin/bash
#SBATCH --job-name=gpu_job              # Job name
#SBATCH --output=gpu_res.txt            # Standard output and error log
#SBATCH --ntasks=1                      # Run a single task
#SBATCH --gres=gpu:1                    # Request 1 GPU
#SBATCH --cpus-per-task=4               # Number of CPU cores per task
#SBATCH --time=03:00:00                 # Time limit hrs:min:sec
#SBATCH --mem=16G                       # Memory needed

                          # Load R module (adjust if necessary)
Rscript gpu_script.R                    # Run the R script
