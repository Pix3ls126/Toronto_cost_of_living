#### Preamble ####
# Purpose: Simulated test data for severity of infraction during inspection
# Author: Aaron Xiaozhou Liu
# Date: April 12, 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca
# Prerequisites: None

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)

#### simulate the data by reported motor theft by police division ####
#based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate

simulated_data <-
  tibble(
    # Use 1 through to 18 to represent each division
    "Inspection" = 1:18,
    # Randomly pick an option, with replacement, 151 times
    "Crime location" = sample(
      x = c("Minor", "Significant", "Minor", "Significant", "Crucial", "Minor"),
      size = 18,
      replace = TRUE
    )
  )