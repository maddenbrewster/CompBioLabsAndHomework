# EBIO5420 
# Lab 4
# Madden Brewster
# February 7, 2020

# PART I: Practice writing "for loops"

# Step #1: write a for loop that prints "hi" to the console 10 times
for (i in seq(1,10)) {
  print("hi")
}

# Step #2: write a for loop that prints (to the console) Tim's total 
# amount of money each week for the next 8 weeks.
tim_initial <- 10 # amount of money Tim has initially 
tim_weekly_allowance <- 5 # Tim's weekly allowance 
tim_gum_packs <- 2 # number of packs of gum Tim buys each week 
gum_cost <- 1.34 # cost ($) of each pack of gum 
num_weeks <- 8 # amount of weeks Tim is saving for 

for (i in seq(1, num_weeks)) {
  tim_final <- tim_initial + (i * tim_weekly_allowance) - (i * (tim_gum_packs * gum_cost)) # equation calculating Tim's total money 
  to_print <- paste("Week #", toString(i), ": $", toString(tim_final)) # use the paste function to concatenate strings 
  print(to_print)
}

# Step #3: write a for loop that calculates the population size given the following 
rate_of_pop_shrink <- 0.05 # rate of population shrinkage (5%) expresses as a decimal  
pop_current <- 2000 # the size of the original population 
num_years <- 7 # the number of years population size will be calculated for 

for (i in seq(1, num_years)) {
  pop_current <- pop_current - (rate_of_pop_shrink * pop_current) # equation to calculate current population
  pop_rounded <- round(pop_current) # since you can't have a portion of a population...rounded so print statments are nicer
  to_print <- paste("Population for year #", toString(i), ":", toString(pop_rounded)) 
  print(to_print)
}

# Step #4: write a loop for the population abundance over time that predicts n[12] given the following parameters
K <- 10000 # environmental carrying capacity 
r <- 0.8 # intrinsic growth rate of the population 
t <- 1 # current time point 
pop_abundance <- 2500 # population abundance n[1]
num_time_step <- 12

for (i in seq(t, num_time_step)) {
  pop_abundance <-  pop_abundance + (r * pop_abundance * (K - pop_abundance) / K) # discrete time logistic growth equation 
  pop_rounded <- round(pop_abundance) # round to make the population number whole 
  to_print <- paste("Population abundance for time", toString(i), ":", toString(pop_rounded)) # make a print statement by pasting together 
  print(to_print) # print the population abudances 
}


# PART II: Practice writing “for loops” AND practice storing the data 
# produced by your loops in arrays

# Step #5: practice some basics of array indexing using loops 
# 5a). Use the rep command to make a vector of 18 zeros 
num_zeros <- 18
zero_vec <- rep(0, num_zeros)

# 5b). make a loop that stores 3 times the ith value of the iterator 
# variable in the ith spot of the vector created in part a
multiplier <- 3 

for (i in seq(1,18)) {
  zero_vec[i] <- i * multiplier
}

# 5c). make a new zero vector and make the first entr of the vector have a value of 1
new_zero_vec <- rep(0, num_zeros)
new_zero_vec[1] <- 1

# 5d). write a for loop that starting with the secon entry of the vector created in part c, 
# the value stored in that position in the vector is equal to one plus twice the value of the 
# previous entry 

for (i in seq(2, 18)) {
  new_zero_vec[i] <- 1 + (2 * new_zero_vec[(i - 1)])
}

# Step #6: using a for loop write code that makes vector of the first 20 Fibonacci numbers where the first number is 0 
Fib_start_num <- 0 # can start at 1 or 0 
amount_Fib_nums <- 20 # how many Fibonacci numbers to put into the vector 
Fib_vector <- rep(0, amount_Fib_nums) # makes a vector of zeros to which will be swapped with Fibonacci numbers 
Fib_vector[2] <- 1 # replace the second index with 1 

for (i in seq(3, amount_Fib_nums)) {
  Fib_vector[i] <- Fib_vector[(i - 2)] + Fib_vector[(i - 1)] 
}

# Step #7: redo question 4 from part I, but now store all of the data 
K <- 10000 # environmental carrying capacity 
r <- 0.8 # intrinsic growth rate of the population 
t <- 1 # current time point 
pop_abundance <- 2500 # population abundance n[1]
num_time_step <- 12 # number of time steps 
pop_vec <- rep(0, num_time_step) # create a vector of 0's to replace with populations 
time_vec <- rep(0, num_time_step) # create a vector of 0's to replace with time points 

for (i in seq(t, num_time_step)) {
  pop_abundance <-  pop_abundance + (r * pop_abundance * (K - pop_abundance) / K) # discrete time logistic growth equation 
  pop_vec[i] <- pop_abundance # store population abundance into ith spot in pop_vector 
  time_vec[i] <- i # store time points in vector 
}

plot(time_vec, pop_vec, xlab = "Time (years)", ylab = "Population Abundance")

# PART III: Optional challenge problems 

# Step #8: Obtain the CO2_data_cut_paste.csv and the MetaData_CO2_emissions.txt files in Sam's Lab04 git repo 

# 8a). Read the data into RStudio (Note: you can use tab to autocomplete in R as well)
setwd("Documents/EBIO5420/CompBioLabsAndHomework/Labs/Lab04") # set working directory to lab 4 folder 
print(getwd()) # make sure you're in the directory you want to be working in 
CO2_data <- read.csv("CO2_data_cut_paste.csv") # read in the csv file 

# 8b). csv columns are imported as integers rather than numeric, so you need to change them to numeric 
# so that you can do math on it (not integer math, which wouldn't let you do continuous numbers)...
# can do this several ways: 1) read in and force them to be numeric (as.numeric will get an error)
CO2_data_numeric <- read.csv("CO2_data_cut_paste.csv", colClasses = c("numeric")) # use the colClasses argument to numeric so that everything gets forcibly read in as numeric
str(CO2_data_numeric) # check that the data is actually numeric usting the str() function 
str(CO2_data) # you can see the difference (the change was actually made) by looking at the previous file import 

# 2) write a for loop to iterate through the columns and change to numeric (other than year)  
# col_amount <- length(CO2_data) # figure out the number of columns in your data so you can felxibly iterate through in the loop, this is less flexible because we need rows too, use dim instead 

rows <- dim(CO2_data)[1] # dim makes a vector of the [rows, columns] so you can access the first element for row number, second for column number 
columns <- dim(CO2_data)[2] 

# one other way you could do it is by using the nrow or ncol functions 
# nrow(CO2_data)
# ncol(CO2_data)

years_column <- grep("Year", colnames(CO2_data)) # get the column number where years is located, so you can start your loop one higher than that
init_col_loop <- (years_column + 1) # where to initiate the loop for the columns 

# write a nested for loop to loop through each individual value in the data frame 
for (i in seq(init_col_loop, columns)){ # this loop loops through each column 
  for (j in seq(1, rows)) { # this loop loops through each row -- note, there
    CO2_data[j,i] <- as.numeric(CO2_data[j,i]) # this changes each value in data_frame[row, column] to numeric 
  }
}


# unlist() function can help change to numeric also, however, this will turn 
# it into a 1 dimensional vector (1 x 2104), so don't do this on datasets 
CO2_data_unlist <- as.numeric(unlist(read.csv("CO2_data_cut_paste.csv")))

# 8c). For each of the quantities in the data frame you just imported, except 
# for the Year, calculate the percent change from year i-1 to year i across 
# all years. Your results should be stored in a new data frame or matrix.


# vectorize or use for loop ...To be continued...



