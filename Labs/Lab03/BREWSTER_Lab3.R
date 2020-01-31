# EBIO5420 Lab 3
# Brewster
# 1/31/20

# Lab step #3
num_chips <- 5
num_guests <- 8

# Lab step #4: average bags of chips each guest will consume 
avg_consumption <- 0.4

# Lab step #8: making vectors for rankings of Star Wars movies 
self <- c(7, 9, 8, 1, 2, 3, 4, 6, 5)
penny <- c(5, 9, 8, 3, 1, 2, 4, 7, 6)
lenny <- c(6, 5, 4, 9, 8, 7, 3, 2, 1)
stewie <- c(1, 9, 5, 6, 8, 7, 2, 3, 4)

# Lab step #9: indexing practice
PennyIV <- penny[6]

# Lab step #10: concatenate rankings into matrix 
ranking_mat <- cbind(self, penny, lenny, stewie)

# Lab step #11: using the str() command
str(PennyIV)
str(penny)
str(ranking_mat)
# str() shows you the different elements of each variable as well as what kind of 
# element it is (i.e. num)

# Lab step #12: making a data frame 
rankings_dataf <- data.frame(ranking_mat)
rankins_dataf_as <- as.data.frame(ranking_mat)
# cbind() makes a matrix and data.frame() makes a data frame. Using the str() 
# command with a matrix tells you what the matrix has sort of but it's messy 
# when you compare it to the data frame using str(). the dimensions of both
# are the same when using the dim() command. When using the == between the 2,
# you will get boolean trues all around if their rows/columns match. However, 
# when using the typeof() command, the matrix will be type double and the data 
# will be type list. 

# lab step #14: making a vector of the episode number 
episode <- c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX")

# Lab step 15: using the row.names() command 
row.names(ranking_mat) <- episode
row.names(rankings_dataf) <- episode

# Lab step 16: accessing elements in two dimensional objects 
ranking_mat[3,]

# Lab step 17: 
rankings_dataf[,4]

# Lab step 18: my ranking of Episode V
rankings_dataf[5,1]

# Lab step 19: Penny's ranking for Episode II
rankings_dataf[2,2]

# Lab step 20: Everyone's rankings for episodes IV-VI
rankings_dataf[4:6,]

# Lab step 21: Everyone's rankings for episodes II, V, and VII
rankings_dataf[c(2,5,7),]

# Lab step 22: Rankings for Penny and Stewie in Episodes IV and VI 
rankings_dataf[c("IV", "VI"), c("penny","stewie")]

# Lab step 23: using indexing to assign new values to entries in matrix or dataframe
rankings_dataf[1,3] = 0

# Lab step 24: using variable names instead of number index 
ranking_mat["III","penny"]
rankings_dataf["III","penny"]

# Lab step #25: using the variable name method to swap numbers 
rankings_dataf["I", "lenny"] = 6

# Lab step #26: 
rankings_dataf$lenny[1] = 0








