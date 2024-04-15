#### Preamble ####
# Purpose: Downloads the data from OpenDataToronto
# Author: Aaron Xiaozhou Liu
# Date: April 3, 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca
# Prerequisites: None

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#Getting the package
pkg <- 
  search_packages('Dinesafe')

#Getting the list of package IDs
pkgs <- 
  list_package_resources(pkg$id)

#Getting the desired dataset
dataset <-
  get_resource(pkgs[2:2,1:2]$id)

#Saving the dataset
write_csv(
  x = dataset,
  file = "data/raw_data/raw_DineSafe_data.csv"
)

