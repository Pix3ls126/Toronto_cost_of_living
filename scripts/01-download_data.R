#### Preamble ####
# Purpose: Downloads the data from OpenDataToronto
# Author: Aaron Xiaozhou Liu
# Date: April, 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca
# Prerequisites: None

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#Getting the package
pkg <- 
  search_packages('Theft from Motor Vehicle')

#Getting the list of package IDs
pkgs <- 
  list_package_resources(pkg$id)

#Getting the desired dataset
dataset <-
  get_resource(pkgs[8:8,1:2]$id)

#Saving the dataset
write_csv(
  x = dataset,
  file = "inputs/data/raw_Theft_from_Motor_Vehicle.csv"
)
