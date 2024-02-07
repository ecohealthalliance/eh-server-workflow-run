library(targets)
library(tibble)
library(dplyr)
library(crew)

Sys.setenv("PATH" = paste0(Sys.getenv("PATH"), ":/usr/local/bin"))

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
    host = Sys.info()["nodename"]
  )
)

targets <- list(
  tar_target(
    name = data_prep,
    command = {Sys.sleep(5); tibble(x = rnorm(100), y = rnorm(100))},
    # Removed iteration = "list" to produce a single tibble
  ),
  tar_target(
    name = data_analysis,
    command = {Sys.sleep(10); cor(data_prep$x, data_prep$y)},
    pattern = map(data_prep)
  ),
  tar_target(
    name = model_fit,
    command = {Sys.sleep(20); lm(y ~ x, data = data_prep)},
    pattern = map(data_prep)
  ),
  tar_target(
    name = post_process,
    command = {Sys.sleep(5); summary(model_fit)},
    pattern = map(model_fit)
  ),
  tar_target(
    name = report,
    command = {
      # Adjusted to directly plot without assuming iteration
      plot(data_prep$x, data_prep$y)
    }
    # pattern = map(data_prep) might be removed if data_prep is not iterated
  )
)

tar_pipeline(targets)
