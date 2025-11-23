#' Run Simulation for Task 1
#'
#' Runs the simulation experiment for Task 1 (condition: x1 < x2, nodesize: 25).
#'
#' @return A data.frame with the mean and variance of misclassification errors.
#' @export
run_task1 <- function() {

  # Define the condition for Task 1
  condition_task1 <- function(x1, x2) {
    as.numeric(x1 < x2)
  }

  # Run the simulation
  message("Running Task 1 (condition: x1 < x2, nodesize: 25)...")
  results <- run_simulation(
    condition_func = condition_task1,
    nodesize = 25
  )
  message("Task 1 complete.")
  return(results)
}

#' Run Simulation for Task 2
#'
#' Runs the simulation experiment for Task 2 (condition: x1 < 0.5, nodesize: 25).
#'
#' @return A data.frame with the mean and variance of misclassification errors.
#' @export
run_task2 <- function() {

  # Define the condition for Task 2
  condition_task2 <- function(x1, x2) {
    as.numeric(x1 < 0.5)
  }

  # Run the simulation
  message("Running Task 2 (condition: x1 < 0.5, nodesize: 25)...")
  results <- run_simulation(
    condition_func = condition_task2,
    nodesize = 25
  )
  message("Task 2 complete.")
  return(results)
}

#' Run Simulation for Task 3
#'
#' Runs the simulation experiment for Task 3
#' (condition: (x1 < 0.5 & x2 < 0.5) | (x1 > 0.5 & x2 > 0.5), nodesize: 12).
#'
#' @return A data.frame with the mean and variance of misclassification errors.
#' @export
run_task3 <- function() {

  # Define the condition for Task 3
  condition_task3 <- function(x1, x2) {
    as.numeric((x1 < 0.5 & x2 < 0.5) | (x1 > 0.5 & x2 > 0.5))
  }

  # Run the simulation
  message("Running Task 3 (XOR-like problem, nodesize: 12)...")
  results <- run_simulation(
    condition_func = condition_task3,
    nodesize = 12
  )
  message("Task 3 complete.")
  return(results)
}

