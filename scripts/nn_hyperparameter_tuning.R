
# ---- Hyperparameter grid ----
grid <- expand.grid(
  #hidden_units = I(list(c(32, 64), c(64, 64, 64))),  # list of vectors for layers
  hidden_units = I(list(
    c(32), c(64), c(128), c(32, 64), c(64, 32),
    c(64, 64), c(128, 128), c(64, 64, 64),
    c(128, 64), c(64, 128)
    )
  ),
  dropout_rate = c(0.2, 0.3),
  learning_rate = c(0.001, 0.0005),
  stringsAsFactors = FALSE
)

# ---- Storage for results ----
results <- data.frame(
  hidden_units = character(),
  dropout_rate = numeric(),
  learning_rate = numeric(),
  val_accuracy = numeric()
)

# ---- Loop through the grid ----
for (i in 1:nrow(grid)) {
  params <- grid[i, ]
  cat("\n\n------------------------------------------------")
  cat("\nTraining model", i, "of", nrow(grid), "\n\n")
  
  # Build model
  model <- build_model(
    n_inputs = ncol(x_train),
    hidden_units = params$hidden_units[[1]],
    n_outputs = length(unique(y_train)),
    dropout_rate = params$dropout_rate,
    learning_rate = params$learning_rate
  )
  
  # Train model (using 20% of train as validation)
  history <- train_model(
    model, x_train, y_train,
    valid_split = 0.2, 
    epochs = 50, batch_size = 32, verbose = 0,
    checkpoint_path = paste0("data/model_", i, "fit.h5")
  )
  saveRDS(history, paste0("data/model_", i, "_history.rds"))
  
  # Record best validation accuracy
  best_val_acc <- max(history$metrics$val_accuracy, na.rm = TRUE)
  
  results <- rbind(results, data.frame(
    hidden_units = paste(params$hidden_units[[1]], collapse = "-"),
    dropout_rate = params$dropout_rate,
    learning_rate = params$learning_rate,
    val_accuracy = best_val_acc
  ))
}

saveRDS(results, file = "data/model4_tuning.rds")

# Find the best hyperparameter combo
best_params <- grid[which.max(results$val_accuracy), ]

