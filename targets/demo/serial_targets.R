library(targets)
library(tidyverse)
library(performance)

list(
  
  tar_target(setosa, as_tibble(iris) |> filter(Species == "setosa")),
  tar_target(setosa_fit, lm(Petal.Width ~ Sepal.Length, data = setosa)),
  tar_target(setosa_plot, check_predictions(setosa_fit)),
  
  tar_target(versicolor, as_tibble(iris) |> filter(Species == "versicolor")),
  tar_target(versicolor_fit, lm(Petal.Width ~ Sepal.Length, data = versicolor)),
  tar_target(versicolor_plot, check_predictions(versicolor_fit)),
  
  tar_target(virginica, as_tibble(iris) |> filter(Species == "virginica")),
  tar_target(virginica_fit, lm(Petal.Width ~ Sepal.Length, data = virginica)),
  tar_target(virginica_plot, check_predictions(virginica_fit))
)