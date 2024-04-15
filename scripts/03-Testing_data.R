#### Preamble ####
# Purpose: Run a test to make sure no data was lost during the cleaning data cleaning process
# Author: Aaron Xiaozhou Liu
# Date: April 13, 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca
# Prerequisites: Have already run 01-download_data.R and 02-cleaning-data.R

# Get length of both the raw and cleaned data
len_raw <- nrow(raw_DineSafe_data)
len_filtered <- nrow(DineSafe_data_Clean)

# Check if the lengths of both files are equal, returns true if both are equal, meaning no rows have been lost
identical(len_raw, len_filtered)