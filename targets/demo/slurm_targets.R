library(targets)
library(crew)
library(crew.cluster)
library(tidyverse)
library(performance)

Sys.setenv("PATH"=paste0(Sys.getenv("PATH"), ":/usr/local/bin"))

tar_option_set(
  controller = crew.cluster::crew_controller_slurm(
    workers = 2,
    host = Sys.info()["nodename"],
    slurm_cpus_per_task = 1,
    slurm_time_minutes = 10,
    slurm_partition = "all",
    slurm_log_output = "slurm_log.txt",
    slurm_log_error = "slurm_error.txt",
    verbose = TRUE,
    script_lines = c(
      "#SBATCH --account=eco",
      "#SBATCH --partition=all")
  )
)

list(
  tar_target(data, iris |> group_by(Species) |> tar_group(), iteration = "group"),
  tar_target(model_fits, lm(Petal.Width ~ Sepal.Length, data = data), map(data)),
  tar_target(model_plots, check_predictions(model_fits), map(model_fits), iteration = "list")
)
