library(crew)

crew::crew_job(
  name = "test",
  cmd = "sbatch submit.sh",
  trigger = "always"
)
