library(crew.cluster)
library(testthat)

script_lines <- c(
  'R.version$version.string',
  'quit(save = "no", status = 0)'
)

controller <- crew_controller_slurm(
  name = "my_workflow",
  workers = 1L,
  seconds_idle = 300,
  verbose = TRUE
)
controller$start()
controller$push( # Should see a job submission message.
  name = "do work",
  command = as.character(Sys.info()["nodename"])
)
controller$wait()
task <- controller$pop()
expect_false(task$result[[1L]] == as.character(Sys.info()["nodename"]))
controller$launcher$terminate() # Should see a job deletion message.
Sys.sleep(5L)
controller$terminate()
