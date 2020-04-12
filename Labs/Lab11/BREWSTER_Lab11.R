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

unique_species_data <- wood_data %>% # %>% deontes a pipe (like in the terminal, so you can keep working with the same metadata)
  group_by(Binomial, Family) %>% # groups unique values of the specified variable 
  summarise(mean(Wood.density)) # gives you the mean for specified variable of interest (can use a number of other statistics instead as well)


# 6. Contrast most and least dense families 
# 6a. Make a new data frame that has the average density for each Family 
# (and no longer has individual species). It might look like this:

unique_family_data <- unique_species_data %>%
  group_by(Family) %>%
  summarise(mean = mean(`mean(Wood.density)`))

str(unique_family_data) #check nummber of rows (should be 191)

# 6b. Sort the result from 6a by MeanDensity and stroe the result in the data frame 
# use arrange() or order() (arrange() requires dplyr() package)
colnames(unique_family_data)[2] <- "MeanDensity" # first change the name of column 
mean_density_sorted_data <- arrange(unique_family_data, MeanDensity) #arrange family data by MeanDensity 

# 6c. Using results from 6b:
# What are the 8 families with the highest average densities?
num_rows <- dim(mean_density_sorted_data)[1]
num_rows_minus_7 <- num_rows - 7
high_density_fam <- mean_density_sorted_data[c(num_rows_minus_7:num_rows),]
high_density_fam
# 1 Asteropeiaceae
# 2 Bonnetiaceae  
# 3 Linaceae      
# 4 Surianaceae   
# 5 Irvingiaceae  
# 6 Sarcolaenaceae
# 7 Zygophyllaceae
# 8 Hypericaceae 

# What are the 8 familites with the lowest average densities?
low_density_fam <- mean_density_sorted_data[c(1:8),]
low_density_fam
# 1 Caricaceae   
# 2 Paulowniaceae
# 3 Moringaceae  
# 4 Bixaceae     
# 5 Hernandiaceae
# 6 Muntingiaceae
# 7 Datiscaceae  
# 8 Tetramelaceae

# Part III: Plotting 
# For these problems, you will need to library("ggplot2")
library(ggplot2)
# 7. Plotting densities of most and least dense families with facets
# Boxplots of the families with the highest average densities (aligned vertically) 
colnames(unique_species_data)[3] <- "MeanDensity"

keepRows <- unique_species_data$Family %in% high_density_fam$Family # uses logical indexing to: find the rows from the unique species dataset if they have the family names that match the family names in the data set with the highest denisty  
high_density_data <- unique_species_data[keepRows, ] # put those rows into a new dataset 

high_density_plots <- ggplot(high_density_data) + # make sure to use the data subset created above 
  geom_boxplot(aes(Family, MeanDensity)) 
high_density_plots # this results in side by side plots, but we want unique grids 

# Below works for this, but the lower grid part is on 
high_density_plots <- ggplot(high_density_data) + # make sure to use the data subset created above 
  geom_boxplot(aes(y = MeanDensity)) +
  facet_wrap(~Family) + # use facet_wrap to split by family 
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) # use theme and other functions to get rid of ticks and axes labels 
high_density_plots

# Boxplots of the familites with the lowest average densities (aligned vertically) 

keepRows_low <- unique_species_data$Family %in% low_density_fam$Family # uses logical indexing to: find the rows from the unique species dataset if they have the family names that match the family names in the data set with the highest denisty  
low_density_data <- unique_species_data[keepRows_low, ] # put those rows into a new dataset 

low_density_plots <- ggplot(low_density_data) + # make sure to use the data subset created above 
  geom_boxplot(aes(y = MeanDensity)) +
  facet_wrap(~Family) + 
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
low_density_plots # this results in side by side plots, but we want unique grids 

# 8. Facilitating comparisons with graphics 

high_density_plots_compare <- ggplot(high_density_data) + 
  geom_boxplot(aes(x = Family, y = MeanDensity)) +
  coord_flip() 
high_density_plots_compare

low_density_plots_compare <- ggplot(low_density_data) + 
  geom_boxplot(aes(x = Family, y = MeanDensity)) +
  coord_flip() 
low_density_plots_compare




