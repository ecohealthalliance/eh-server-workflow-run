
# eh-server-workflow-run

## Overview
This guide outlines the process for running various analytic workflows on the EHA infrastructure using the SLURM workload manager (formerly <ins>S</ins>imple <ins>L</ins>inux <ins>U</ins>tility for <ins>R</ins>esource <ins>M</ins>anagement). It covers various topics from basic job submissions to advanced utilization of resources, including handling large datasets, interactive job execution, batch job submission, management of long-running processes, and leveraging GPU resources. Workload managers like SLURM have three major benefits.

1. Parallel computing: Workload managers provide tools to start, stop, and monitor parallel jobs
2. Resource management: Workload managers help manage resource allocation. For example, they can impose time or resource limits on jobs or provide a single access point to multiple physical servers.
3. Task scheduling: Workload managers help arbitrate job submission by providing a job queue. That means jobs can be submitted immediately and only run when resources become available.  

## Table of Contents
1. [Workload manager overview](#workload-managers)
2. [EHA compute resources](#compute-resources)
3. [Basic Job Submission](#basic-job-submission)
5. [Handling Large Datasets](#handling-large-datasets)
6. [Interactive Jobs](#interactive-jobs)
7. [Long-Running Jobs](#long-running-jobs)
8. [Utilizing GPU Resources](#utilizing-gpu-resources)
9. [Workflow management](#workflow-management) 
10. [Parallel Processing in R](#parallel-processing-in-r)
11. [Targets workflow manager](#targets)
12. [Crew cluster](#Crew)

---

### Objective
To demonstrate how to submit simple R scripts that require minimal computation or memory in a Slurm-managed environment.

## Workload manager overview

Interacting with compute resources often involves tools that help manage the workflow of individual projects, such as `targets` or `snakemake`, as well as tools that manage the workload of all the different jobs submitted to the server, such as `SLURM`. Workload managers prevent conflict by establishing a job queue and a priority list of jobs. This allows users to submit jobs that automatically start when resources become available without having to first communicate with all the other users of the server. In addition, workload managers provide tools to assist in parallel computing tasks. Interacting with the workload manager can be done directly from the command line or from within project workflow management tools. 

## Basic Job Submission
At it's core a job script is just a script submitted to Slurm that requests access to resources.

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

- ` Submit a job`  : sbatch .jobs/jobFile.job

- ` See the entire job queue (note that you are allowed 5000 in queue at once)`: squeue

- ` See only jobs for a given user`: squeue -u username

- `  kill a job with ID $PID` : scancel $PID

- ` Kill ALL jobs for a user` : scancel -u username

- ` Kill all pending jobs` :  scancel -u username --state=pending

- `Stop and restart jobs interactively with SLURM's scancel.`:  scancel -s SIGSTOP job id

- `Run interactive node with 16 cores (12 plus all memory on 1 node) for 4 hours ` : srun -n 12 -N 1 --mem=64000 --time 4:0:0 --pty bash

- `Claim interactive node for exclusive use, 8 hours ` srun --exclusive --time 8:0:0 --pty bash

- `Same as above, but with X11 forwarding ` : srun --exclusive --time 8:0:0 --x11 --pty bash
 - ` Same as above, but with priority over your other jobs ` : srun --nice=9999 --exclusive --time 8:0:0 --x11 --pty -p dev -t 12:00 bash

- `Count number of running / in queue jobs ` : squeue -u username | wc -l

- `Get estimated start times for your jobs (when sycorax is busy)` : squeue --start -u username

- `Request big memory node for 4 hours` : srun -N 1 -p bigmem -t 4:0:0 --pty bash

- `Run a job with 1 node, 4 CPU cores, and 2 GPU`: srun -N 1 -n 4 --gres=gpy:2 -p gpu --qos=gpu



### Submitting the Job
Submit your job using the `sbatch` command. This submits your job to the queue. It will be run whenever resources become available.
```bash
sbatch submit_simple.sh

```

### Checking Job Status

To check the status of your job, use the squeue command:

```
squeue --user=[your_username]
```

## Handling Large Datasets


## Interactive Jobs


## Long-Running Jobs


## Workflow management
Workflow management tools provide a means to organize, automate, and connect all the different parts of a research project. Scripts that collect, clean, and analyze data often require different methods, packages, or even software. Without a workflow management tool each step would have to be run by hand every time the data changes or analaysis approaches are refined. This can be tedious and often leads to problems when the steps of a project are run out of order, lowering reproducibility of results. The two main workflow management tools used at EHA are

1. [targets](https://books.ropensci.org/targets/) for projects that use `R` and
2. [snakemake](https://snakemake.readthedocs.io/en/stable/) for projects that use `python`
3. [Nextflow](https://www.nextflow.io/) Develop container-backed, reproducible workflows portable across computational platforms including local, HPC schedulers, AWS Batch, Google Genomics Pipelines, and Kubernetes
4. [Metaflow](https://metaflow.org/) Metaflow is a human-friendly Python/R library that helps scientists and engineers build and manage real-life data science projects.

Both worklfow managers provide methods to interact direclty the SLURM workload manager. Additional information is avialable for accessing SLURM for both [targets](https://books.ropensci.org/targets/hpc.html) and [snakemake](https://snakemake.readthedocs.io/en/v7.19.1/executing/cluster.html). Further information on using SLURM with targets can be found [below](#Targets workflow manager)

https://snakemake.readthedocs.io/en/stable/



## Parallel Processing in R

There are a number of packages that enable parallel processing in R. The [parallel](https://bookdown.org/rdpeng/rprogdatascience/parallel-computation.html) and the [future](https://dcgerard.github.io/advancedr/09_future.html) packages are two common options. See the provided links for more information on each approach. 

A fundamental concept in parallel computing is [Amdahl's law](https://en.wikipedia.org/wiki/Amdahl%27s_law). Due to the accumulation of overhead when scheduling and launching parallel tasks, **running a job across more cores in parallel does not always produce faster results**. That means using every available core for a task will generally not make things faster. Always save some compute power for background tasks and, if possible, identify the expected speedup before launching a highly parallel job by running a small test beforehand to prevent occupying resources that do provide any benefit.

![Amdahl's law](https://en.wikipedia.org/wiki/File:AmdahlsLaw.svg)

## Targets workflow manager

Resources for learning about and utilizing the `targets` project management framework is available in the [EHA handbook](https://ecohealthalliance.github.io/eha-ma-handbook/3-projects.html). In brief, targets, splits a project into skippable chunks. If chunks become outdated due to new data or updated analysis, they can be re-run without having to start the project pipeline from the begining. Targets also provides conveniet methods to interact with AWS storage and workload managers such as SLURM.

### Branching

In additional targets provides it's own method to intelligently manage parallel jobs through the use of [dynamic](https://books.ropensci.org/targets/dynamic.html) and [static](https://books.ropensci.org/targets/static.html) branching. Branching further splits up each skippable project chunk into independant computational tasks. For example, branching can be used to fit a model to every row of a dataframe or to repeat the same task across every file in a directory. While branching can seem daunting at first it provides a convenient way to add parallel computing to a project. Branches represent independent tasks. For intensive tasks, targets can interact with `SLURM` using distributed worker frameworks such as [crew](https://books.ropensci.org/targets/crew.html).

### Crew cluster

Targets leverages parallel computing to efficiently process a large and complex pipeline by running multiple independant targets at the same time. `crew` permits these targets to be run on high-performance computing platforms. Invoking the crew controller involves adding a piece of code at the top of the `_targets.R` script. That lets targets know how many workers to use.

```

# Define how to interact with SLURM
tar_option_set(
  packages = c("tibble", "dplyr"),
  resources = list(
    slurm_cpus_per_task = 1,
    slurm_time_minutes = 10,
    slurm_partition = "all"
  ),
  controller = crew.cluster::crew_controller_slurm(
    workers = 2,
    slurm_cpus_per_task = 1,
    slurm_time_minutes = 10,
    slurm_partition = "all",
    slurm_log_output = "slurm_log.txt",
    slurm_log_error = "slurm_error.txt",
    verbose = TRUE,
    seconds_idle = 300,
    script_lines = c(
      "#SBATCH --account=eco",
      "#SBATCH --partition=all"
    ),

```

### Example targets scripts that use SLURM

```
# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline
# install.packages(c("targets", "crew", "crew.cluster")
# Load packages required to define the pipeline:
library(targets)
library(tibble)
library(dplyr)
# library(tarchetypes) # Load other packages as needed.
Sys.setenv("PATH"=paste0(Sys.getenv("PATH"), ":/usr/local/bin"))
# Set target options:
tar_option_set(
  controller = crew.cluster::crew_controller_slurm(
    workers = 2,
    slurm_cpus_per_task = 1,
    slurm_time_minutes = 10,
    slurm_partition = "all",
    slurm_log_output = "slurm_log.txt",
    slurm_log_error = "slurm_error.txt",
    tls_enable = NULL,
    tls_config = NULL,
    tls = crew::crew_tls(mode = "automatic"),
    verbose = TRUE,
    seconds_idle = 300,
    script_lines = c(
      "#SBATCH --account=eco",
      "#SBATCH --nodelist=aegypti_worker",
      "#SBATCH --partition=all"
      
    ),
    host=Sys.info()["nodename"]
    
  )
)

controller$start()

# Replace the target list below with your own:
list(
  tar_target(
    name = data,
    command = tibble(x = rnorm(100), y = rnorm(100), tar_group = rep(1:10, 10)),
    iteration = "group",
    # format = "feather" # efficient storage for large data frames,
    
  ),
  tar_target(
    name = model,
    command = coefficients(lm(y ~ x, data = data)),
    pattern = map(data)
  )
)

```



