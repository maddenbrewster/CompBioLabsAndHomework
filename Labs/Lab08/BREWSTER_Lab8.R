# EBIO5420 
# Lab08
# Madden Brewster 
# March 11, 2020 


# 3. Recall problem #7 from [Week 4's lab (on writing loops)](https://github.com/flaxmans/CompBio_on_git/blob/master/Labs/Lab04/Lab04_ForLoops.md).  
# That problem asked you to write code that could implement the discrete-time 
# logistic growth model.  Starting with that code, please do the following:

# a. Create a new script in a directory for Lab08 that contains this code 
# (it is fine to copy and paste from your own work)

# b. Turn the logistic growth model code into a function that takes `r` 
# (the intrinsic growth rate), `K` (the carrying capacity), the total number
# of generations, and the initial population size as its arguments. 

# Step #7 from Lab04: redo question 4 from part I, but now store all of the data 
# Step #4 from Lab04: # Step #4: write a loop for the population abundance over time 
# that predicts n[12] given the following parameters:
 
log_growth_model <- function(r, K, generations, pop_initial) {
  pop_vec <- rep(1, generations) # create a vector of 1's to replace with populations for the number of generations requested 
  time_vec <- rep(1, generations) # create a vector of 1's to replace with time points 
  for (i in seq(2, generations)) {
    pop_vec[1] <- pop_initial 
    pop_initial <-  pop_initial + (r * pop_initial * (K - pop_initial) / K) # discrete time logistic growth equation 
    pop_vec[i] <- pop_initial # store population abundance into ith spot in pop_vector 
    time_vec[i] <- i # store time points in vector 
  }
# c. Add code to the function so that it produces a plot of the data it 
# generates (i.e., it should plot abundance over time).  Note that the axes 
# should be labeled appropriately.
  plot(time_vec, pop_vec, xlab = "Time (years)", ylab = "Population Abundance") # plot the time and population abundance 
  time_pop_mat <- cbind(time_vec, pop_vec) # put them into a 2 column matrix using cbind() command 
  colnames(time_pop_mat) <- c("Generation", "Population Abundance") # name the columns appropriately 
  return(time_pop_mat) # return the matrix as the result 
}

# d. Following the function, write a line(s) of code that calls the function 
# (you choose the parameter values).
log_growth_model_to_save <- log_growth_model(0.8, 10000, 12, 2500)

# For part of BONUS 2
setwd("/Documents/EBIO5420/CompBioLabsAndHomework/Labs/Lab08") # I am having a ton of trouble changing my wd here...even though using getwd() I know I'm at /Users/maddenbrewster/, I keep getting a "cannot change working directory" error.
jpeg("log_growth_plot.jpg") # open a jpeg and name it appropriately
plot(log_growth_model_to_save[,1],log_growth_model_to_save[,2], xlab = "Time (years)", ylab = "Population Abundance") # plot the model -- Can you do 2 returns? so I don't have to do this down here and can get it from my funciton as well 
dev.off() # close the file 

# e. Write a line(s) of code that writes the data set to a file (also in your
# Lab08 directory).  The data file should have two columns: the first column 
# should be "generations", and the second column should be "abundance".
write.csv(x = log_growth_model_to_save, file = "Log_Growth_Model.csv") # write the file to a csv. 


