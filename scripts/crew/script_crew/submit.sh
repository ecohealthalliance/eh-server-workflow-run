#!/bin/bash
#SBATCH --requeue               # Requeue the job in case of failure


#SBATCH --nodes=1               # Number of nodes to use
#SBATCH --tasks-per-node=1      # Number of tasks per node
#SBATCH --cpus-per-task=20      # Number of CPU cores per task
#SBATCH --partition=all         # Partition to submit to
#SBATCH --mem=50G               # Memory allocation (50 GB)
#SBATCH --time=00-0:4:0         # Time limit (days-hours:minutes:seconds)
#SBATCH --output=slurm_output.txt

Rscript crew.R
