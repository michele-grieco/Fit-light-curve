# Fit-light-curve

# ETR vs PPFD Model Fitting for Barley Field Data

This repository contains Python code for fitting an electron transport rate (ETR) model to photosynthetically-active photon flux density (PPFD) data collected from barley grown in the field. The model is used to assess the relationship between ETR and PPFD using a non-linear least squares method, evaluating the goodness of fit, and visualizing the results.

## Overview

### Data:
The data in this repository come from barley plants grown in the field. The measurements include photosynthetically-active photon flux density (PPFD) and the corresponding electron transport rate (ETR). One additional data point at the origin (0, 0) has been added to ensure the model captures the starting point.

### Model:
The following non-linear model is used to describe the relationship between ETR and PPFD:

\[
\text{ETR} = \text{ETRmax} \times (1 - \exp(-k \times \text{PPFD}))
\]

Where:
- **ETRmax** is the maximum electron transport rate.
- **k** is the rate constant.
- **PPFD** is the photosynthetically-active photon flux density, representing the number of photons in the photosynthetically active spectrum (400–700 nm) that hit a given surface area per unit of time (measured in µmol m⁻² s⁻¹).

### Tasks:
- **Data Processing**: A data point at the origin is added to the dataset.
- **Model Fitting**: Fit the non-linear model.
- **Evaluate Goodness of Fit**: Metrics such as Residual Standard Error (RSE), pseudo R-squared, and AIC are calculated.
- **Visualize the Results**: Plot the ETR vs PPFD data and the fitted curve, as well as the standardized residuals vs predicted values.

## Requirements

Install the necessary libraries before running the script:

```bash
pip install numpy pandas matplotlib scipy
