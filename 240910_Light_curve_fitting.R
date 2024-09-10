

# Load necessary libraries
library(ggplot2)

# Read data from the uploaded file
curve_data <- read.csv("data.csv")  # Replace with the actual path to your file

# Add a data point at the origin (0, 0)
curve_data <- rbind(curve_data, data.frame(PPFD = 0, ETR = 0))

# Set initial values of parameters
ETRmax_start <- 150
k_start <- 0.0015

# Fit the model
fit <- nls(ETR ~ ETRmax * (1 - exp(-k * PPFD)), 
           data = curve_data, 
           start = list(ETRmax = ETRmax_start, k = k_start))

# Extract fitted parameters
ETRmax <- coef(fit)["ETRmax"]
k <- coef(fit)["k"]

# Create a new data frame with fitted values
curve_data$ETR_fitted <- ETRmax * (1 - exp(-k * curve_data$PPFD))

# Plot using ggplot2
ggplot(curve_data, aes(x = PPFD)) +
  geom_point(aes(y = ETR), color = 'blue', size = 2) +  # Plot the original data
  geom_line(aes(y = ETR_fitted), color = 'red', size = 1) +  # Plot the fitted curve
  labs(title = paste("ETR vs PPFD (ETRmax =", round(ETRmax, 2), ", k =", round(k, 4), ")"),
       x = "PPFD", y = "ETR") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "bottom") +  
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 14)) +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5)) +
  theme(strip.text = element_text(size = 14, face = "bold")) +  
  theme(legend.text = element_text(size = 12, colour = "black")) +
  theme(legend.title = element_text(size = 14, face = "bold"))

# Calculate residuals
residuals <- residuals(fit)

# 1. Residual Standard Error (RSE)
rss <- sum(residuals^2)  # Residual sum of squares
n <- length(residuals)  # Number of observations
p <- length(coef(fit))  # Number of parameters
rse <- sqrt(rss / (n - p))  # Residual standard error

# 2. R-squared (pseudo R-squared for non-linear model)
tss <- sum((curve_data$ETR - mean(curve_data$ETR))^2)  # Total sum of squares
r_squared <- 1 - (rss / tss)

# 3. AIC (Akaike Information Criterion)
aic <- AIC(fit)

# Output the results
cat("Goodness of fit metrics:\n")
cat("Residual Standard Error (RSE):", rse, "\n")
cat("Pseudo R-squared:", r_squared, "\n")
cat("AIC:", aic, "\n")

# Standardize the residuals
standardized_residuals <- residuals / rse

# Create a data frame for plotting standardized residuals
residuals_data <- data.frame(Predicted = predict(fit), Standardized_Residuals = standardized_residuals)

# Plot the standardized residuals vs predicted values
ggplot(residuals_data, aes(x = Predicted, y = Standardized_Residuals)) +
  geom_point(color = 'blue') +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Standardized Residuals vs Predicted Values",
       x = "Predicted Values",
       y = "Standardized Residuals") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "bottom") +  
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 14)) +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5)) +
  theme(strip.text = element_text(size = 14, face = "bold")) +  
  theme(legend.text = element_text(size = 12, colour = "black")) +
  theme(legend.title = element_text(size = 14, face = "bold"))
