#' @importFrom stats runif predict var
#' @importFrom randomForest randomForest
#' @importFrom tidyr pivot_longer
#' @importFrom tidyselect starts_with
NULL

#' Run a Random Forest Simulation Experiment
#'
#' This is a helper function to run the simulation described in Assignment 1.
#' It generates test data, then loops n_sim times to generate training data,
#' fit random forests, and calculate misclassification errors.
#'
#' @param n_sim Number of simulations to run. Default is 1000.
#' @param n_train Size of each training dataset. Default is 100.
#' @param n_test Size of the test dataset. Default is 1000.
#' @param condition_func A function that takes two arguments (x1, x2) and returns
#'   the binary class label (0 or 1).
#' @param nodesize The 'nodesize' parameter for randomForest.
#' @param ntree_vec A vector of 'ntree' values to test. Default is c(1, 10, 100).
#' @param seed Seed for reproducibility of test data. Default is 1234.
#'
#' @return A long-format data.frame with the results of all simulations,
#'   ready for plotting. Contains columns: `simulation_id`, `ntree`, `error_rate`.
#' @export
run_simulation <- function(n_sim = 1000, n_train = 100, n_test = 1000,
                           condition_func, nodesize,
                           ntree_vec = c(1, 10, 100), seed = 1234) {

  # --- 1. Generate the fixed test dataset ---
  # Set seed for reproducibility of the test data
  set.seed(seed)
  test_x1 <- stats::runif(n_test)
  test_x2 <- stats::runif(n_test)
  # Use data.frame with explicit, consistent column names
  tedata <- data.frame(x1 = test_x1, x2 = test_x2)
  # Apply the condition function
  test_y <- condition_func(test_x1, test_x2)
  telabels <- as.factor(test_y)

  # Matrix to store errors from all simulations
  # Each row is a simulation, each column is an ntree setting
  errors_matrix <- matrix(NA, nrow = n_sim, ncol = length(ntree_vec))
  colnames(errors_matrix) <- paste0("ntree_", ntree_vec)

  # --- 2. Run the simulations ---
  for (i in 1:n_sim) {
    # Generate training data (no seed set here, so it's different each time)
    train_x1 <- stats::runif(n_train)
    train_x2 <- stats::runif(n_train)
    # Use data.frame with the *same* explicit column names
    trdata <- data.frame(x1 = train_x1, x2 = train_x2)
    train_y <- condition_func(train_x1, train_x2)
    trlabels <- as.factor(train_y)

    # Train models for each ntree value
    for (j in 1:length(ntree_vec)) {
      ntree_val <- ntree_vec[j]

      # Fit the random forest
      # Removed set.seed(i + j) to allow natural randomness in RF construction
      rf_model <- randomForest::randomForest(
        x = trdata,
        y = trlabels,
        ntree = ntree_val,
        nodesize = nodesize,
        keep.forest = TRUE
      )

      # Predict on the test data
      predictions <- stats::predict(rf_model, newdata = tedata)

      # Calculate misclassification error
      misclassification_error <- mean(predictions != telabels)

      # Store the error
      errors_matrix[i, j] <- misclassification_error
    }
  }

  # --- 3. Format and return all results ---

  # Convert matrix to a long-format data.frame for easy plotting
  results_df <- as.data.frame(errors_matrix)
  results_df$simulation_id <- 1:n_sim

  long_results <- tidyr::pivot_longer(
    results_df,
    cols = starts_with("ntree_"),
    names_to = "ntree_setting",
    names_prefix = "ntree_",
    values_to = "error_rate"
  )

  # Convert ntree_setting back to numeric for plotting
  long_results$ntree <- as.numeric(long_results$ntree_setting)

  return(long_results)
}

