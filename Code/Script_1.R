
###Loading libraries
install.packages('tidyverse')
install.packages('here')
install.packages('readxl')

library(tidyverse)
library(here)
library(readr)
library(ggplot2)
library(readxl) 



###Load data

raw_data <- read_excel(here('Data','Weekly_Fuel_Prices.xlsx'),skip=7,sheet='All years')


#### this did not work -> read_excel('Weekly_Fuel_Prices.xlsx',skiprows=7,sheet='All years')


head(raw_data)

getwd()


here()
