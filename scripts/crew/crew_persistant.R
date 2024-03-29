library(crew.cluster)
library(testthat)
x <- crew_controller_slurm(
  name = "123",
  workers = 1L,
  seconds_idle = 300,
  slurm_log_error = "slerr.txt",
  slurm_log_output = "slout.txt",
  seconds_idle = 300,
  script_lines = c(
    "#SBATCH --account=eco",
    "#SBATCH --nodelist=aegypti_worker",
    "#SBATCH --partition=all"
    
  ),
  host=Sys.info()["nodename"]
 
  
)
x$start()
n <- 200
for (index in seq_len(n)) {
  name <- paste0("task_", index)
  x$push(name = name, command = as.character(Sys.info()["nodename"]))
  message(paste("push", name))
}
results <- list()
while (length(results) < n) {
  out <- x$pop()
  if (!is.null(out)) {
    results[[length(results) + 1L]] <- out
    message(paste("done", out$name, out$result[[1]]))
  }
}
x$terminate()
results <- tibble::as_tibble(do.call(rbind, results))
results$result <- as.character(results$result)
expect_equal(length(unique(results$result)), 1L)
expect_false(anyNA(results$result))
expect_false(any(results$result == as.character(Sys.info()["nodename"])))
expect_equal(results$error, rep(NA_character_, n))
expect_equal(
  sort(paste0("task_", seq_len(n))),
  sort(unique(results$name))
)

