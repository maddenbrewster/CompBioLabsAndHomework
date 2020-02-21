# EBIO5420 
# Lab 5
# Madden Brewster
# February 17 2020 

# PART I: Practice simple conditionals

# 1. Create a variable named `x` and assign a numeric value of your choosing to it.  
# On the next line of code, write an if-else statement that checks if the value 
# is larger than 5.  Your code should print a message about whether the value 
# is larger or smaller than 5.

x <- 3
if (x > 5) {
  print("This value is greater than 5.")
} else {
  print ("This value is smaller than 5.")
}

# 2. Download ExampleData.csv from Sam's Github folder. 

setwd("/Users/maddenbrewster/Documents/EBIO5420/CompBioLabsAndHomework/Labs/Lab05")
ex_data <- read.csv("ExampleData.csv")

# 2a. Using a `for()` loop, write code that checks each value in the imported data 
# and changes every negative value to be `NA`.  Note: `NA` is an actual value in R 
# that acts as a placeholder and/or signifies that data are missing/absent
# /not-applicable for a particular position in a data object. 

r <- dim(ex_data)[1] # use the dim() function to get number of rows in your data 

for (i in seq(1,r)) { # for loop starting at 1 through number of rows 
  if (ex_data[i,] < 0) { # conditional, if the value in the row you are looking for is negative
    ex_data[i,] <- as.numeric("NA") # replace that value with NA...make sure you specify as.numeric, otheriwse it will change data frame to type character 
  }
}

# 2b. Using vectorized code (no loop) that makes use of "logical" indexing, change 
# all those `NA` values with `NaN`.  Note that `NaN` is a numeric value meaning 
# "not a number".  Also note that R has a function, `is.na()`, for testing if 
# something is an `NA`.    You can NOT use `==` on `NA` values or `NaN` values.

ex_vec_NA_values <- is.na(ex_data) 
ex_data[ex_vec_NA_values] <- NaN

# 2c. Using  a `which()` statement and integer indexing (again, no loop), change 
# all those `NaN` values with a zero.  Note that R has a function, `is.nan()`, for 
# testing if something is an `NaN`.  You can NOT use `==` on `NA` values or `NaN` values.

ex_vec_NaN_values <- which(is.na(ex_data))
ex_data[ex_vec_NaN_values,1] <- 0 

# 2d. Use code to determine how many of the values from the imported data fall in 
# the range between 50 and 100 (inclusive of those endpoints). 


count <- 0 # create a counter variable to count the nmber of values that fall in the correct range 
for (i in seq(1,r)) { # go through the data frame row by row 
  if (ex_data[i,1] >= 50 & ex_data[i,1] <= 100){ # if statment to check if in the correct range 
    count <- count + 1 # if it is in the correct range, add 1 to the counter variable 
  }
}
print(count) # print the number you found 


# 2e.  Using any method of your choice, create a new vector of data that has all the values 
# from the imported data that fall in the range between 50 and 100.  Do NOT dynamically 
# grow the array, however.  This vector should be named "FiftyToOneHundred". 

index_50_100 <- which(ex_data > 50 & ex_data < 100) # use the which() command to find the numerical indices of where values are > 50 & < 100 and then...
FiftyToOneHundred <- ex_data[index_50_100,] # use numerical indexing to put them into a new vector 

# 2f.  Use `write.csv()` to save your vector to a file named "FiftyToOneHundred.csv".  
# Please use all default settings with `write.csv()`.  In other words, assuming that your 
# current working directory is your own directory for your work for Lab05, save it with the 
# command `write.csv(x = FiftyToOneHundred, file = "FiftyToOneHundred.csv")`

write.csv(x = FiftyToOneHundred, file = "FiftyToOneHundred")


# 3. Import the data on CO2 emissions from last week's lab ("CO2_data_cut_paste.csv" from Lab04).  
# Read the accompanying metadata (in a plain text file in the same directory) to learn what the 
# data represent.  Use code to answer the following questions.  Hint: you do NOT need to use 
# any loops here.  Use some combination of `which()`, logical operators, and/or indexing:

CO2_data <- read.csv("CO2_data_cut_paste.csv")

# 3a. What was the first year for which data on "Gas" emissions were non-zero?

non_0_indices <- which(CO2_data$Gas != 0) # use which command to find the indices where Gas is non 0 and put it into a vector
first_gas_row <- non_0_indices[1] # take the first element of the vector created in the line above (this will be the row of the first year with Gas emmisions)
first_gas_year <- CO2_data$Year[first_gas_row] # now find corresponding year for the correct row 

print("The first year with Gas emmisions were:",first_gas_year) # print the answer

# 3b. During which years were "Total" emissions between 200 and 300 million metric tons of carbon?

total_200_300 <- which(CO2_data$Total >= 200 & CO2_data$Total <= 300) # find the row indices where Total emmsions are between 200 and 300
total_200_300_years <- CO2_data[total_200_300,"Year"] # use the row indices to find corresponding years 

print(total_200_300_years) # print those years 


# PART II: Loops + Conditionals + Biology 

# Write code that calculates abundances of predators and prey over time according to 
# the Lotka-Volterra predator-prey model. 

# The model: 
# n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
# p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])


# First, set up parameter values.  Use the following: 

totalGenerations <- 1000
initPrey <- 100 	# initial prey abundance at time t = 1
initPred <- 10		# initial predator abundance at time t = 1
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators

# Second, create a time vector, and make two additional vectors to store results, one 
# for the values of `n` over time, and the other to store values of `p`.  Note that the
# time vector is literally meant to be just a sequence of numbers representing time steps 
# from 1 to `totalGenerations` and that it is NOT needed until the fifth and sixth 
# steps below. 

time <- seq(1, totalGenerations) # time vector 
prey_abund_over_time <- seq(1, totalGenerations) # prey abundance over time 
pred_abund_over_time <- seq(1, totalGenerations) # predator abundance over time 

# Third, write a loop that implements the calculations.

for (i in seq(1,totalGenerations)) {
  prey_abund_over_time[i] <- initPrey # add each population abundance to the correct index of the vector we made above
  pred_abund_over_time[i] <- initPred
  initPrey <- initPrey + (r * initPrey) - (a * initPrey * initPred) # do the calculations for the model 
  initPred <- initPred + (k * a * initPrey * initPred) - (m * initPred)
}

# Fourth, in this model it is possible that the predators may kill off all the prey.  
# Due to the discrete nature of how time is considered in this model (time proceeds 
# in discrete jumps from one generation to the next), it is possible that the calculations
# as given can result in negative numbers.  So, **add some `if` statements** to your 
# code to check for negative numbers each generation.  **If, for example, a given value 
# of prey abundance is negative, then that value should be set to be zero**.

for (i in seq(1,totalGenerations)) {
  prey_abund_over_time[i] <- initPrey # add each population abundance to the correct index of the vector we made above (put this at the top to make sure you get initial populations in the vector)
  pred_abund_over_time[i] <- initPred
  if (initPrey < 0) { # if statment to change any negative numbers to 0's 
    initPrey <- 0 
  }
  if (initPred < 0) {
    initPred <- 0 
  }
  initPrey <- initPrey + (r * initPrey) - (a * initPrey * initPred) # do the calculations for the model 
  initPred <- initPred + (k * a * initPrey * initPred) - (m * initPred)
}

# Fifth, make a plot of the abundances of prey and predators over time (see cheat 
# sheet above for using `plot()` and `lines()`).

plot(time, prey_abund_over_time, type = "l", col = "green", xlab = "Time", ylab = "Population Abundance") # use the plot command to plot the model 
lines(time, pred_abund_over_time, col = "purple") # use the line command to add an extra line 
title("Lotka Volterra Predator Prey Model")
legend(2,150,c("Prey Abundance", "Predator Abundance"), lwd = c(2,2), col = c("green", "purple"), cex = 0.5) # the first 2 numbers are postion, lwd is for adding the line, cex is to make the box of the legend size

# Sixth, create a matrix of your results named "myResults" in which the first column 
# is named "TimeStep", the second column is named "PreyAbundance", and the third column 
# is named "PredatorAbundance".  Write this matrix to a csv in your Lab05 working 
# directory with the command `write.csv(x = myResults, file = "PredPreyResults.csv")` 
 
myResults <- cbind(time, prey_abund_over_time, pred_abund_over_time) # make a matrix usingn the cbind() command 
colnames(myResults) <- c("Time", "PreyAbundance", "PredatorAbundance") # head the column names properly 
write.csv(x = myResults, file = "PredPreyResults.csv")
