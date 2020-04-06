# EBIO5420 
# Lab 11
# Madden Brewster 
# March 19, 2020 

# Part I: Getting set up to work with the data 
# Make sure tidyverse package is installed:
install.packages("tidyverse")

# 1. Download the data from: https://doi.org/10.5061/dryad.234
# 2. Turn data from .xlx to .csv
# 3. Start R script for the lab and use read.csv to import it

setwd("Documents/EBIO5420/CompBioLabsAndHomework/Labs/Lab11")
wood_data <- read.csv("GlobalWoodDensityDatabase.csv", stringsAsFactors = F)
colnames(wood_data)[4] <- "Wood.density" # rename column with really long name 

# Part II: Working with density data 

# 4. Removing rows with missing data 
# It turns out there is one entry (out of 16468) in the data for 
# which there is no density entered.  It will import as `NA`.

# 4a. Which row is it?
wood_rows <- dim(wood_data)[1] # get number of rows in the the data set 
wood_col <- dim(wood_data)[2] # get number of columns in data set 

for (i in seq(1,wood_rows)) {
  for (j in seq(1,wood_col)) {
    if (is.na(wood_data[i,j])) {
      na_row_index <- i # I know this isn't very helpful if there is more than 1 NA...brain is not working right now on how to make it more sophisticated 
    }
  }
}

# I also tried this, which I found on stack overflow...way easier than nested loop, but have to use is.na()...wood_data == NA does NOT WORK 
na_row_index <- which(is.na(wood_data), arr.ind = TRUE)[1] # get the row number 
# Row 12150 is the row with the NA value 

# 4b. Remove row from missing data 
wood_data <- wood_data[-c(na_row_index), ] # remove row using - 
str(wood_data) # check to make sure a row was deleted (16468 entries to begin with, so should be less now)

# 5. Dealing with one kind of pseudo-replication 
# Create a new data frame that:
# has each species listed only once,  
# has the `Family` and `Binomial` information for each species, and  
# has the mean of the `Density` measurements for each species
library(dplyr) # need dplyr to use group_by() and summarise()

wood_data %>% # %>% deontes a pipe (like in the terminal, so you can keep working with the same metadata)
  group_by(Binomial) %>% # groups unique values of the specified variable 
  summarise(mean(Wood.density)) # gives tou the mean for specified variable of interest (can use a number of other statistics instead as well)



