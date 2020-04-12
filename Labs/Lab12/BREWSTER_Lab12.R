# EBIO5420 
# Lab 12 
# Madden Brewster 
# Sunday, April 12, 2020 

# More work with ggplot2
# Problems work with the Cusack et al. Dataset 
setwd("/Users/maddenbrewster/Documents/EBIO5420/CompBioLabsAndHomework/Labs/Lab12")
cam_data <- read.csv("Cusack_et_al_data.csv", stringsAsFactors = F)

# Problem 1: A bar plot in ggplot()
# All the species' names (all 41 of them) are indeed there on the x-axis, and the y-axis is the total number of observations
# of each species in the whole dataset.
library(ggplot2)
library(dplyr)

# One way to do this: takes longer, but first you subset data  by unique names with frequencies 
unique_species_freq <- cam_data %>% 
  group_by(Species) %>%
  summarise(species_frequency = length(Species)) # give the frequency for each unique species by taking the length of th number of rows of each unique species 

cam_barplot <- ggplot(unique_species_freq, aes(x = Species, y = species_frequency)) +
  geom_bar(stat = "identity") # must inclues thid because you specify an x any y above, with geom_bar, r only expects to get an x and will calcualte frequency from that 
cam_barplot


# use this, much easier; uses original data and also less to code altogether  
cam_barplot <- ggplot(cam_data) + 
  geom_bar(aes(Species))
cam_barplot  

# Problem 2: Rotate the axis tick labels.
cam_barplot_2 <- ggplot(cam_data) + 
  geom_bar(aes(Species)) +
  theme(axis.text.x = element_text(angle = 90)) # use the theme and combined elements to adjust axis text angle 
cam_barplot_2 

# Problem 3: A different orientation, scaling, and sorting
sorted_species_data <- arrange(unique_species_freq, species_frequency) # this uses the code from probelm 1
cam_barplot_3 <- ggplot(sorted_species_data, x = Species, y = species_frequency)) + 
  geom_bar(stat = "identity") + # remeber this is required because you sepcifices an x and y variable above
  scale_y_log10() + 
  coord_flip() 
cam_barplot_3

# this still doens't give me what I want, can't get the order correct--not sure how to rememdy this. Is there  way to turn off R's default alphebatization?



  
  