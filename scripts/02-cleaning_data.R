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
library(zoo)

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

#Getting amounts fined
Infraction_fines <- data.frame(
  Date = as.character(cleaned_DineSafe_data$inspection_year_month),
  amount_fined = as.numeric(cleaned_DineSafe_data$amount_fined)
)
Infraction_fines <- Infraction_fines[!is.na(Infraction_fines$amount_fined), ]

Infraction_fines <- aggregate(amount_fined ~ Date, data = Infraction_fines, FUN = sum)

Infractions_fines_by_date <- merge(Infraction_fines, Inspections_per_year, by = "Date", all = TRUE)

Infractions_fines_by_date$amount_fined <- na.fill(Infractions_fines_by_date$amount_fined, 0)

write_parquet(Inspections_per_year, "data/analysis_data/Inspections_fines_per_year.parquet")
