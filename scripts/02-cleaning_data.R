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
library(arrow)

# Read the raw data
raw_DineSafe_data <-
  read_csv(
    file = "data/raw_data/raw_DineSafe_data.csv",
    show_col_types = FALSE
  )

# Clean the raw data
cleaned_DineSafe_data <-
  clean_names(raw_DineSafe_data)

# removing null rows
DineSafe_data_Clean <- cleaned_DineSafe_data[cleaned_DineSafe_data$infraction_details != "", ]

DineSafe_data_Clean <- DineSafe_data_Clean[!is.na(DineSafe_data_Clean$id), ]

split_column <-
  strsplit(DineSafe_data_Clean$establishment_address, " ")

# stripping the address
new_column <- sapply(split_column, function(x) paste(x[2], x[3], sep = " "))

DineSafe_data_Clean$Establishment_Street <- new_column

write_parquet(DineSafe_data_Clean, "data/analysis_data/cleaned_DineSafe_filtered.parquet")

write_parquet(cleaned_DineSafe_data, "data/analysis_data/cleaned_DineSafe.parquet")
# stripping date
cleaned_DineSafe_data$inspection_year_month <- format(cleaned_DineSafe_data$inspection_date, "%Y-%m")

unique_dates <- unique(cleaned_DineSafe_data$inspection_year_month)

unique_dates <- na.omit(unique_dates)

date_counts <- table(cleaned_DineSafe_data$inspection_year_month)

Inspections_per_year <- data.frame(
  Date = as.character(unique_dates),
  Inspection_count = as.numeric(date_counts)
)

write_parquet(Inspections_per_year, "data/analysis_data/Inspections_per_year.parquet")

