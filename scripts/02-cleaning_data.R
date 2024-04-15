#### Preamble ####
# Purpose: Cleans the dataset downloaded from opendatatoronto
# Author: Aaron Xiaozhou Liu
# Date: April 5, 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca
# Prerequisites: running 01-download_data.R

#### Workspace setup ####
#install.packages("tidyverse")
#install.packages("janitor")

library(tidyverse)
library(janitor)

# Read the raw data
raw_DineSafe_data <-
  read_csv(
    file = "inputs/data/raw_DineSafe_data.csv",
    show_col_types = FALSE
  )

# Clean the raw data
cleaned_DineSafe_data <-
  clean_names(raw_DineSafe_data)

cleaned_DineSafe_data <- cleaned_DineSafe_data[cleaned_DineSafe_data$infraction_details != "", ]

DineSafe_data_Clean <- cleaned_DineSafe_data[!is.na(cleaned_DineSafe_data$id), ]

write_csv(
  x = DineSafe_data_Clean,
  file = "inputs/data/cleaned_DineSafe.csv"
)