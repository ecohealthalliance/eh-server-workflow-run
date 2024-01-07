library(targets)
library(crew.cluster)

# Define a simple target
list(
  tar_target(
    data,
    rnorm(100)  # Example: generating 100 random numbers
  )
)
