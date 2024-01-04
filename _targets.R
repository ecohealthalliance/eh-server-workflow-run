# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline
# install.packages(c("targets", "crew", "crew.cluster")
# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  controller = crew.cluster::crew_controller_slurm(
    workers = 4,
    slurm_cpus_per_task = 1,
    slurm_time_minutes = 10,
    slurm_partition = "all")
)

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
