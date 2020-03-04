# EBIO5420: Lab #7
# Madden Brewster
# February 28, 2020

# Problem #1: The area of a triangle can be calculated as `0.5 * base * height`.  
# Write a function named `triangleArea` that calculates and returns the area 
# of a triangle when given two arguments (base and height).  
triangle_area <- function(base, height) {
  area = 0.5 * base * height # triangle area equation 
  return(area) # don't need an explicit return if it is the last line of the funcgi
}

# Demonstrate that your function works by calling it for an imaginary 
# triangle that has a base of 10 units and a height of 9 units.
triangle_area(10, 9)


# Problem #2: R has a built in function called `abs()` that returns the 
# absolute value of a number, or the absolute value of each number in a 
# numeric vector.  Imagine that the `abs()` function did NOT exist.  

# Part 2a.  Write a function named `myAbs()` that calculates and returns 
# absolute values.
myAbs <- function(num1) {
  if (num1 < 0) {
    num1 <- num1 * -1 # make the number positive if it is negative 
  }
  return(num1)
}

# Show that your function works by using it on the following test cases:
# the number `5`
# the number `-2.3`
myAbs(5) # call the function 
myAbs(-2.3)

# Part 2b. Revise your function to make it work on vectors (unless it 
# already does).  Demonstrate that your (revised) function works on the 
# following vector: 
  
# `c(1.1, 2, 0, -4.3, 9, -12)`
vec1 <- c(1.1, 2, 0, -4.3, 9, -12)

myAbs <- function(vec) { # argument is a vector
  for (i in seq(1, length(vec))) { # for i in sequence 1 through the length of the argument vector
    if (vec[i] < 0) { # if element at index i is negative, 
      vec[i] <- vec[i] * -1 # make the number positive if it is negative 
    }
  }
  return(vec) # return the absolute values of the vector elements  
}

myAbs(vec1) # call the function 

# Problem #3: Using the information given in that quote, write a function 
# that returns a vector of the first `n` Fibonacci numbers, where `n` is 
# any integer >= 3.  Your function should take **two** arguments: the user's 
# desired value of `n` and the user's desired starting number (either 0 or 
# 1 as explained in the quote above).  Your function does NOT need to TEST 
# if `n` is actually >= 3.  (In other words, we are assuming that `n >= 3`.  
# That is a sensible assumption because your for loop from lab 4 probably 
# wouldn't work if you used `n < 3`.)  However, note Bonus 3a below if you 
# are interested.

fib_numbers <- function(n, start_num) {
  fib_vector <- rep(0, n) # pre allocate vector of zeros 
  fib_vector[2] <- 1 # make sure the second element in the vector is 1
  if (start_num == 1) { # if the user would like to start with 1, 
    fib_vector[1] <- 1 # then make the first element in the vector 1
  }
  for (i in seq(3, n)) {
    fib_vector[i] <- fib_vector[(i - 2)] + fib_vector[(i - 1)] 
  }
  return(fib_vector)
}

fib_numbers(20,0) # call functions to check 
fib_numbers(20,1)

# *Bonus 3a* (optional): make your function work for n = 1 and n = 2.  (Hint: add conditionals)

fib_numbers <- function(n, start_num) {
  fib_vector <- rep(0, n) # pre allocate vector of zeros 
  if (start_num == 1) { # if the user would like to start with 1, 
    fib_vector[1] <- 1 # then make the first element in the vector 1
  }
  if (n == 1) {
    return(fib_vector)
  } else if (n == 2) {
    fib_vector[2] <- 1 # make sure the second element in the vector is 1
  } else {
    fib_vector[2] <- 1 # make sure the second element in the vector is 1
    for (i in seq(3, n)) {
    fib_vector[i] <- fib_vector[(i - 2)] + fib_vector[(i - 1)] 
    }
  }
return(fib_vector)
}

# Bonus 3b* (optional): make your function check user input, e.g., if a user 
# enters zero, or a negative number, or a non-integer number, the function 
# should check that and give an appropriate error/warning message.  
# (Hint: more conditionals)

fib_numbers <- function(n, start_num) {
  fib_vector <- rep(0, n) # pre allocate vector of zeros 
  int_val_logi <- is.integer(n) # create a logical value to check if it is an integer 
  start_val_logi <- is.integer(start_num)
  if (n < 1 || int_val_logi == FALSE || start_num < 0 || start_val_logi == FALSE) { # big if statment to check and see if something is negative or not an integer
    print("ERROR: You must enter a positive integer greater than 0 for the first argument") # print error message 
  } else {
      if (start_num == 1) { # if the user would like to start with 1, 
        fib_vector[1] <- 1 # then make the first element in the vector 1
      }
      if (n == 1) { # if the size of the sequence is 1, just return the vector 
        return(fib_vector)
      } else if (n == 2) { # else if the size of the sequence is 2, 
        fib_vector[2] <- 1 # make sure the second element in the vector is 1
      } else {
        fib_vector[2] <- 1 # make sure the second element in the vector is 1
        for (i in seq(3, n)) {
          fib_vector[i] <- fib_vector[(i - 2)] + fib_vector[(i - 1)] # fib sequence equation 
        }
      }
    return(fib_vector)
    }
}

# Problem #4a: Write a function that takes two numbers as its arguments 
# and returns the square of the difference between them.  In other words, 
# for any two numbers `x` and `y` your function should calculate and return
# the quantity `(x - y) ^ 2
square_diff <- function(x, y) {
  return((x - y) ^ 2)
}

# Demonstrate that your function works by calling it with the numbers 3 
# and 5.  (your function should return the number 4). 
square_diff(3,5) # call the function to test it 

# Call your function where the first argument is the vector `c(2, 4, 6)` 
# and the second argument is the number `4`.    Your function should 
# return the vector `4 0 4`.  This is a demonstration of R's abilities 
# to vectorize operations.
square_diff(c(2, 4, 6), 4)

# Part 4b: Imagine that R did NOT have a function to calculate the 
# average (i.e., arithmetic mean) of a vector of numbers.  Write a 
# function of your own that calculates the average of a vector of 
# numbers.  In other words, your function should take a vector of 
# numbers as its argument, and it should return the average, but 
# you can NOT use the `mean()` function.  *Hint*: you will probably 
# want to make use of the `sum()` function for efficiency.

average_function <- function(vec1) {
  vec_avg <- sum(vec1) / length(vec1) # calculate average of vector 
  return(vec_avg) # return average
}

# Demonstrate that your function works by calling it with the vector 
# `c(5, 15, 10)`
average_function(c(5, 15, 10))

# Demonstrate that your function works by calling it with the data you 
# will find in the "DataForLab07.csv" file found in Sam's Lab07 directory.
# **Remember**: importing this data will, by default, create a data frame 
# (not a vector).  If your function works properly, the answer it returns 
# will be approximately `108.9457`.  
setwd("Documents/EBIO5420/CompBioLabsAndHomework/Labs/Lab07") # set wd
avg_data <- read.csv("DataForLab07.csv") # read in example data 
avg_data_vec <- avg_data[,1] # make the data frame a vector so that you can actually use your function
average_function(avg_data_vec) # call the function to test 

# Part 4c: Write a function that calculates and returns the sum of squares 
# as defined here.  Your function should take a vector of numeric data as
# its argument.  Note: please write your sum of squares function so that 
# it makes use of the functions written for the previous two parts of this 
# problem.  In other words, find a useful way to call those functions from 
# within your sum of squares function.

sum_of_squares <- function(num_vec) {
  avg <- average_function(num_vec) # find the mean of the vector by calling on average functionb created above 
  sq_diff_vec <- rep(0, length(num_vec)) # preallocate empty vector 
  for (i in seq(1, length(num_vec))) { # for 1 thorugh the size of the vector 
    sq_diff_vec[i] <- square_diff(num_vec[i], avg) # call the square difference function to find the square difference at that point  and place them in a vector  
  }
  return(sum(sq_diff_vec)) # sum all of the values created in the vector above and return this value 
}

sum_of_squares(avg_data_vec)

