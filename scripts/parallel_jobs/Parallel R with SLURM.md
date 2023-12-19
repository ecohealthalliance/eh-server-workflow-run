SLURM is a workload manager for organizing computing resources in Linux clusters. In order to submit jobs to a cluster managed via SLURM, these have to be submitted via bash scripts that call the actual program to run

When launching parallel R scripts in a cluster, you need to call SLURM with the appropriate options depending on your needs (basically, how many CPUs you want to use)


This script launches the R script TEST.R with 20 cores and for a maximum of  4 minutes. The output and error files will hold the messages and error outputs arising from your R script. These may be set to /dev/null, if you do not want to keep them. This script will allocate 1 * 1 * 20 CPUs, so you could specify 20 workers/cores in your R script and each would be allocated one CPU. Other options include the time allocated to the job  or the RAM memory allocated