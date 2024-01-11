library(crew.cluster)
library(testthat)
Sys.setenv("PATH"=paste0(Sys.getenv("PATH"), ":/usr/local/bin"))
script_lines <- c(
  'R.version$version.string',
  'quit(save = "no", status = 0)'
)

controller <- crew_controller_slurm(
  name = "my_workflow",
  workers = 1L,
  seconds_idle = 300,
  verbose = TRUE,
   slurm_partition = 'gpu',
   script_lines= 'which R > ev.txt; env >> ev.txt; exit 0',
  script_directory = getwd(),
  slurm_log_error = "slerr.txt",
  slurm_log_output = "slout.txt",
  host=Sys.info()["nodename"]

  )

controller$start()
controller$push( # Should see a job submission message.
  name = "do work",
  command = Sys.info()
)
#controller$wait()
controller$unresolved()
task <- controller$pop()
expect_false(task$result[[1L]] == as.character(Sys.info()["nodename"]))
controller$launcher$terminate() # Should see a job deletion message.
Sys.sleep(5L)
controller$terminate()
