#!/bin/bash

#SBATCH --requeue               # Requeue the job in case of failure


#SBATCH --nodes=1               # Number of nodes to use
#SBATCH --tasks-per-node=1      # Number of tasks per node
#SBATCH --cpus-per-task=20      # Number of CPU cores per task
#SBATCH --partition=all         # Partition to submit to
#SBATCH --mem=50G               # Memory allocation (50 GB)
#SBATCH --time=00-0:4:0         # Time limit (days-hours:minutes:seconds)

#SBATCH --chdir=/home/espirado/scripts-test  # Working directory
#SBATCH --output=/home/espirado/scripts-test/output.txt   # Standard output file
#SBATCH --error=/home/espirado/scripts-test/error.txt     # Standard error file

# Load R (if required, adjust if R is loaded differently in your environment)
#cd /home/espirado/scripts-test


# Execute the R script
srun /usr/local/bin/Rscript --no-save /home/espirado/scripts-test/paralell.R
