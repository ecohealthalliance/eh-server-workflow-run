#!/bin/bash
#SBATCH --array=4-14
#SBATCH --partition=all 

# This is a basic array job.  Submit with `sbatch ./03.array.sh`

echo "Hello- I'm task ${SLURM_ARRAY_TASK_ID} of job ${SLURM_ARRAY_JOB_ID}"
echo "There are ${SLURM_ARRAY_TASK_COUNT} tasks in this array"