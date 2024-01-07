#!/bin/bash
#SBATCH --job-name=my_computation_with_package
#SBATCH --partition=all  # Replace with the desired partition
#SBATCH --nodelist=aegypti_worker
#SBATCH --cpus-per-task=10          # Request 10 CPUs
#SBATCH --output=output.log         # Redirect standard output
#SBATCH --error=error.log           # Redirect standard error

# Load any necessary modules or set environment variables (if needed)


# Run the R script
Rscript test.R

# Exit the script
