# eh-server-workflow-run
Outlines how you can run various analytic workflows on EHA infrastructure

Section 1: Basic Job Submission
The goal is to demonstrate how to submit simple R scripts to Slurm that require minimal computation or memory.

```
#SBATCH: This is a Slurm directive. Lines beginning with #SBATCH are comments for the shell but directives for the Slurm scheduler. Each directive specifies scheduling parameters.
--job-name: Sets a name for the job for easier identification.
--output: Determines where the standard output and error log of the job are written.
--time: Optionally specifies the maximum time the job is allowed to run.
--mem: Optionally sets the amount of memory required for the job.
--cpus-per-task: This Slurm directive is crucial for parallel processing. It specifies the number of CPU cores you request for your task. In the example, we request 4 cores.


```

# Submitting the Job

To submit the job, use the sbatch command followed by the name of the Slurm script:

```
sbatch submit_simple.sh

```

## Checking Job Status

To check the status of your job, use the squeue command

```
squeue --user=[your_username]

```

Setup of Parallel Environments in R

The parallel package is a part of the R base packages, offering easy-to-use parallel computing functionalities.

detectCores() is used to find out the number of available cores.

mclapply() is a parallelized version of lapply, allowing you to apply a function over a list or vector in parallel. The mc.cores argument specifies the number of cores to use.

# Large Datasets

This section aims to provide examples of handling large datasets in R within a Slurm environment. Efficient data handling is crucial for performance, especially when dealing with big data.


 # Interactive Jobs

  The goal is to illustrate how users can run R interactively within a Slurm environment

  Use the salloc command to request an interactive session with Slurm.
  ```
  salloc --ntasks=1 --cpus-per-task=4 --mem=8G --time=02:00:00

  ```

  This command will allocate the resources and provide you with a shell on the allocated node

  Now, you can work interactively in R, just like you would on your local machine.

  Once you're done, you can exit R by typing quit() or pressing Ctrl+D.

  Exit the interactive Slurm session by typing exit at the command prompt.

  salloc is used for allocating resources and starting an interactive session in Slurm.
You can specify the number of CPUs, amount of memory, and time duration for your interactive session using various flags like --cpus-per-task, --mem, and --time.

Always remember to exit your interactive session when you're done to free up resources for other users.


The srun command is another way to launch interactive jobs in Slurm. It is typically used to execute a job step directly, but can also be used for interactive work

```
srun --pty --ntasks=1 --cpus-per-task=4 --mem=8G --time=02:00:00 /bin/bash

```
 # Long-Running Jobs

 The goal is to provide strategies and techniques for managing long-running R jobs in a Slurm environment. This includes addressing challenges such as job timeouts and ensuring the continuity of computations over extended periods.

This Slurm script includes considerations for walltime and might use features like job array for managing multiple instances or re-submission.


# GPU

Ensure your R script can leverage GPU (e.g., using R libraries that support GPU acceleration).