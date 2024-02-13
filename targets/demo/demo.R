library(tidyverse)
library(targets)

#######################
### SERIAL PIPELINE ###
#######################

# Run the serial pipeline
tar_make(script="serial_targets.R", store="serial")

# Look at an output plot
tar_load(versicolor_plot, store="serial")

# Look at the pipeline
tar_visnetwork(script="serial_targets.R", store="serial", targets_only = T)


##########################
### PARALLEL PIPELINE ####
##########################

# Run the parallel pipeline
tar_make(script="parallel_targets.R", store="parallel")

# Look at an output plot
tar_read(model_plots, store="parallel")[[1]]

# Look at the pipeline
tar_visnetwork(script="parallel_targets.R", store="parallel", targets_only = T)


#######################
### SLURM PIPELINE ####
#######################

# Run the slurm pipeline
tar_make(script="slurm_targets.R", store="slurm")

# Look at an output plot
tar_read(model_plots, store="slurm")[[1]]

# Look at the pipeline
tar_visnetwork(script="slurm_targets.R", store="slurm", targets_only = T)
