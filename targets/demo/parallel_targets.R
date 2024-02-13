library(targets)
library(tidyverse)
library(performance)

list(
  tar_target(data, iris |> group_by(Species) |> tar_group(), iteration = "group"),
  tar_target(model_fits, lm(Petal.Width ~ Sepal.Length, data = data), map(data)),
  tar_target(model_plots, check_predictions(model_fits), map(model_fits), iteration = "list")
)
