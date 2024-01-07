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
7. [Crew cluster](#Crew)

---


### Objective
To demonstrate how to submit simple R scripts that require minimal computation or memory in a Slurm-managed environment.

## Basic Job Submission
A job script is just a script submitted to Slurm.

```
#!/bin/bash

# Job Options- must be before *any* executable lines

#SBATCH --job-name="HelloWorld"
#SBATCH --output=HelloWorld.%j.out

echo "Hello, World"
```

The hash-bang line ensures you get the shell you intend (`bash` is the default).  Everything that follows is executed within the job.  Submit this with:

```
sbatch test.sh
```

One distinguishing feature of a Slurm batch job is that the script can contain options for the `sbatch` command.  The `sbatch` command has a bunch of different options to control the job and its execution- while you can use these on the command line, having these options within the script ensures consistent execution.

Any options you add on the command line override options in the script.


## single line job submission 

A situation where you just want to run an Rscript with slurm 

```
myString <- "Hello, World!"

print ( myString)
```

srun --partition=all  --nodes=1 --ntasks=1  --mem=10G --time=00:00:10 Rscript test.R 
```
--partition=all: Specifies the partition (or queue) where the job should run. In this case, it's the all partition.
--nodes=1: Requests one node for the job.
--ntasks=1: Specifies that one task is to be launched. This is typically used for parallel jobs, but specifying one means your job will only start a single instance of the task.
--mem=10G: Requests 10 gigabytes of memory for the job.
--time=00:00:10: Sets the time limit for the job. In this case, it's 10 seconds, which is quite short. Make sure this duration is sufficient for your script to complete. For longer scripts, you'll need to increase this time.
Rscript test.R: The command to execute the R script named test.R.

```

To request one node, with 10 tasks and 2 CPUs per task (a total of 20 CPUs), 1GB of memory, for one hour 

srun --partition=all  --nodes 1 --ntasks 10 --cpus-per-task 2  --mem=1G --time=01:00:00 

To request two nodes, each with 10 tasks per node and 2 CPUs per task (a total of 40 CPUs), 1GB of memory, for one hour

srun --partition=all  --nodes 2 --ntasks 10 --cpus-per-task 2  --mem=1G --time=01:00:00 


### Slurm Directives
- `Worker` Nodes (Compute Nodes)
 - Also known as compute nodes, these are the servers or machines in a cluster where the actual computational workloads (jobs) are executed. Each worker node typically has its own set of resources like CPUs, memory, storage, and possibly GPUs.
- `Controller`: The controller, often referred to as slurmctld (Slurm controller daemon), is a central management daemon that oversees all the scheduling   of jobs and resources. It is responsible for:
  - Allocating resources to jobs. 
  - Monitoring jobs and nodes.
  - Managing the job queue.

- `Partitions`: In Slurm, a partition is a logical grouping of nodes and can be thought of as a "queue" where jobs are submitted. Each partition can have its own set of configurations, such as:
  - Limits on job sizes.
  - Time limits.
  - Access control (which users or groups can submit jobs to it).
  - Default and maximum number of nodes allowed per job.

- `Job Scheduling`: This refers to how Slurm decides where and when to run submitted jobs. The scheduler takes into account:
     - The resources requested by each job (like CPUs, memory, time).
     - The availability of resources on nodes.
     - The policies set on partitions.
     - Priorities of jobs (which can be influenced by factors like user priority, job size, waiting time).
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
