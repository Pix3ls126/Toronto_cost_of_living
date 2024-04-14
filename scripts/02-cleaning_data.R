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
  clean_names(raw_Dinesafe_data)

# Converting month into it's numerical equivalent
# Done based off of https://www.reddit.com/r/Rlanguage/comments/m35q4i/comment/gqo21ql/?utm_source=share&utm_medium=web2x&context=3
cleaned_motor_theft_data$occ_month_num <- match(cleaned_motor_theft_data$occ_month, month.name)

# Combining occ_month, occ_day, and occ_year into one column
# Based off code from https://datacornering.com/how-to-join-year-month-and-day-into-a-date-in-r/
Full_date <- as.Date(ISOdate(year = cleaned_motor_theft_data$occ_year,
                             month = cleaned_motor_theft_data$occ_month_num,
                             day = cleaned_motor_theft_data$occ_day))

cleaned_motor_theft_data$full_occ_date <- Full_date

# Filtering cleaned dataset for the desired columns and saving writing into a csv
filter_cleaned_motor_theft_data <- select(cleaned_motor_theft_data, event_unique_id, full_occ_date, occ_day, occ_month, occ_year, division, premises_type)

# Filtering out redundant data before the year 2014
filter_cleaned_motor_theft_data_before_2014 <-
  filter_cleaned_motor_theft_data %>%
  filter(occ_year > 2013)

write_csv(
  x = filter_cleaned_motor_theft_data_past_2014,
  file = "inputs/data/cleaned_Theft_from_Motor_Vehicle.csv"
)