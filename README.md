# eh-server-workflow-run

## Overview
This guide outlines the process for running various analytic workflows on the EHA infrastructure using Slurm. It covers a range of topics from basic job submissions to advanced utilization of resources, including handling large datasets, interactive job execution, management of long-running processes, and leveraging GPU resources.

## Table of Contents
1. [Basic Job Submission](#basic-job-submission)
2. [Parallel Processing in R](#parallel-processing-in-r)
3. [Handling Large Datasets](#handling-large-datasets)
4. [Interactive Jobs](#interactive-jobs)
5. [Long-Running Jobs](#long-running-jobs)
6. [Utilizing GPU Resources](#utilizing-gpu-resources)

---

## Basic Job Submission
### Objective
To demonstrate how to submit simple R scripts that require minimal computation or memory in a Slurm-managed environment.

### Slurm Directives
- `#SBATCH`: Used for Slurm directives. These lines are shell comments but are interpreted by Slurm.
- `--job-name`: Sets a name for easier job identification.
- `--output`: Specifies where to write standard output and error logs.
- `--time`: (Optional) Sets the maximum allowed time for the job.
- `--mem`: (Optional) Defines the amount of memory required.
- `--cpus-per-task`: Specifies the number of CPU cores per task; crucial for parallel processing.

### Submitting the Job
Submit your job using the `sbatch` command:
```bash
sbatch submit_simple.sh

```

### Checking Job Status

To check the status of your job, use the squeue command:

```
squeue --user=[your_username]
```

### Parallel Processing in R

The `parallel` package in R provides straightforward tools for parallel computing.

# Key Functions 
`detectCores()`: Identifies the number of available CPU cores.
` mclapply() `: A parallelized version of lapply for applying functions over lists/vectors in parallel.
