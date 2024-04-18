#### Preamble ####
# Purpose: Models the cleaned data derived from OpenDataToronto's datasets using linear regression
# Author: Aaron Xiaozhou Liu
# Date: April 13, 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R and 02-data_cleaning.R have already been run.

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(here)

#### Read data ####
analysis_data <- read_parquet(file = here("data/analysis_data/Inspections_fines_per_year.parquet"))

first_model <- lm(amount_fined ~ Inspection_count, data = analysis_data)

summary(first_model)

saveRDS(
  first_model,
  file = "model/first_model.rds"
)

