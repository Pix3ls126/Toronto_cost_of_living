#### Preamble ####
# Purpose: Models the cleaned data derived from OpenDataToronto's datasets using poisson regression
# Author: Aaron Xiaozhou Liu
# Date: April 13, 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R and 02-data_cleaning.R have already been run.

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet(file = "data/analysis_data/inspections_fines_per_year.parquet")

first_model <- glm(Inspection_count ~ amount_fined, data = analysis_data, family = poisson)

summary(model)

saveRDS(
  first_model,
  file = "model/first_model.rds"
)

