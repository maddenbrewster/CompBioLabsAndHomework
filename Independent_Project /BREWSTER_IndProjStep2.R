# EBIO5420 
# Independent Project Step 2
# Madden Brewster 
# Due: Thursday, April 30, 2020 

# PREREQUISITES: 
# Make sure you have any packages you need for functions to run: 
library(ggplot2) # For plotting 
library(tidyr)  # required for gather function 
library(car) # required for Levene test function

# GETTING DATA IN WORKING ORDER:
# First download the data set you will be using:
setwd("~/Documents/EBIO5420/CompBioLabsAndHomework/Independent_Project ") # set working directory 
og_data <- read.csv("SCI_data.csv", stringsAsFactors = F) # download original data 
data_label <- "SCI_MVs" # This needs to be changed by the user for appropriate labels when saving graphs/tables 

# Visualize data: 
View(og_data) # make sure everything imported in the way you expected 
# Keep in mind, data should have the 1st 2 rows as characters with the "Group" in the first column, and "Subject" 
# in the second column. All other columns should be of type numeric with numeric values for the different biomarkers 
str(og_data) # make sure everything is as you expected (numbers as number, characters as characters, etc)

# Remove any blank rows (NA), use the first column, because 1st column will always be blank if no subject is there
na_row_index <- which(is.na(og_data), arr.ind = TRUE)[1] # which rows are NA in the first column, and DO return the array indices of these 
og_data <- og_data[-c(na_row_index), ] #remove the empty row

# Now remove any empty columns 
na_index <- which(is.na(og_data), arr.ind = TRUE) # don't specify index here 
na_col_index <- na_index[,2] # take the second column, which will give you the columns there are na's, (matrix is row, colum of NA)

# issue is that it will tell you when ANY of the columns are have an NA, so if missing a single value, will delete the person 
# altogether...let's go with the approach to check column names to get rid of empty columns

# let's go with if there's more than 5 of that number, we remove since there is probably not enough data for that variable to make approrpaite comparisons
uniq_na_col_ind <- unique(na_col_index) # find the unique indices of the columns
freq_matrix_na_col <- as.data.frame(table(na_col_index))
freq_matrix_na_col$na_col_index <- as.numeric(as.character(freq_matrix_na_col$na_col_index)) # must change into numeric, have to change from factors to characters first and then numeric or it won't work 

col_to_remove <- rep(0,nrow(freq_matrix_na_col)) # preallocate a matrix to figure out indices of columns to remove 
for (i in seq(1:nrow(freq_matrix_na_col))) {
  if (freq_matrix_na_col[i,2] > 5) {
    col_to_remove[i] <- freq_matrix_na_col[i,1] # create a vector of the columns to remove 
  }
}
col_to_remove <- col_to_remove[col_to_remove != 0] # get rid of 0's by logical indexing 
og_data <- og_data[ ,-c(col_to_remove)] # if you remove 1 by 1 in the loop, row numbers change, so have to be careful and do it outside loop using the array above

# need to make sure all the values are numeric, it won't work if you import as numeric because the first 2 columns are characters and should stay that way 
for (i in 3:length(og_data)) { # do it as a for loop so that unlisting doesn't 1st collapse all data into a 1 dimensional vector 
  og_data[,i] <- as.numeric(unlist(og_data[,i]))
}

# MAKE ALL YOUR FUNCTIONS: 

# User input functions - 
# This function has no arguments, but gives the user a list of options to choose from as to how they want to analyze the data 
# It returns the user's choice as a numeric value 
first_analysis_choice_func <- function( ) { # just to keep all print statemnts together 
  print("Please choose what data you would like to analyze from the following options: ")
  first_options <- c("All data", "Single Biomarker")
  for (i in seq(1:length(first_options))) {
    print(paste(i, ": ", first_options[i], sep = ""))
  }
  return(first_choice <- as.numeric(readline()))
}

# This function takes the arguments of the biomarker (header) names as a vector and gives a list of options to choose from and
# returns the user's choice as a numeric value
biomarker_choices_func <- function(marker_names) {
  print("Please choose which biomarker to analyze: ")
  for (i in seq(1:length(marker_names))) {
    print(paste(i, ": ", marker_names[i], sep = ""))
  }
  return(biomarker_choice <- as.numeric(readline()))
}

# This function asks the user what type of graph they would like. It takes no arguments and returns the user's choice
# as a numeric value 
graph_type_choice_func <- function ( ) {
  print("Would you like to represent your data as a bar graph or a dot plot?")
  print("1. Bar graph")
  print("2. Dot plot")
  return(as.numeric(readline()))
}

# Table functions - 
# This is to preallocate a "skeleton" table. Keep in mind, dimensions are hard coded here, but the summary table should 
# not change, so the hard coding should be sufficient. The arguments are the data in wide format and the name of the specific marker of interest as a string.
# The function returns a table with the appropriate labels, but no numbers for the data (other than 0's as placeholders)
skeleton_table_func <- function (data_wide, marker_name) {
  sum_table_col1 <- c("Sample Size", "Normality Test", "Normality (p-value)", "Distribution", "Homogeneity of Variance Test", "Homogeneity (p-value)", "Statistical Test", "Statistical Test (p-value)", "Significance", "Mean", "Standard Deviation", "Standard Error", "Median", "Lower Quartile", "Upper Quartile")
  sum_table_col2 <- rep(0, length(sum_table_col1))
  sum_table_col3 <- rep(0, length(sum_table_col1))
  sum_table <- cbind(sum_table_col1, sum_table_col2, sum_table_col3) # bind into matrix 
  colnames(sum_table)[1] <- marker_name # the header needs to change depending on the marker, which is wh is is an argument
  group_names <- unique(data_wide$Group) # find unique names for your dependent variables so that they can be your headers
  colnames(sum_table)[2] <- group_names[1] # rename columns to group name 
  colnames(sum_table)[3] <- group_names[2]
  group_1_samp_size <- sum(with(data_wide, Group == group_names[1]))  # sample size in group 1 
  group_2_samp_size <- sum(with(data_wide, Group == group_names[2])) # sample size in group 2
  sum_table[1,2] <- group_1_samp_size
  sum_table[1,3] <- group_2_samp_size
  sum_table[2,2:3] <- "Shapiro-Wilk Test"
  sum_table[5,2:3] <- "Levene's Test"
  return(sum_table)
}

# Normality testing
# This function takes the data in wide format as well as the column to analyze and performs a Shapiro-Wilk normality test. 
# It returns the p-value from that test. 
norm_SW_test_func <- function(wide_data, cols_to_analyze){
  norm_p_val <- shapiro.test(wide_data[,cols_to_analyze])$p.value # need to be able to normality test all of them 
  return(norm_p_val)
}

# This function takes the data in wide format as well as the column to analyze and performs a Levene's test for homogeneity of variance. 
# It returns the p-value from that test. 
norm_Lev_test_func <- function(wide_data, cols_to_analyze) {
  norm_p_val <- leveneTest(wide_data[,cols_to_analyze]~wide_data$Group)$Pr
  return(norm_p_val)
}

# This function puts whether a t-test can be used in binary terms. It takes the p values from the Shapiro Wilk and Levene Tests
# as arguments and returns a numeric 0 (t-test cannot be performed) or 1 (t-test can be performed). 
can_t_test_be_used <- function(lev_p_val, SW_p_val) {
  if (lev_p_val < 0.05 | SW_p_val < 0.05) {
    norm_p_val <- 0 
  } else {
    norm_p_val <- 1
  }
  return(norm_p_val)
}

# This function takes the p values (numeric) for the Shapiro-Wilk and Levene tests and gives them the appropriate categories
# to put into the table. It returns both of the labels as strings in a vector.  
inf_test_typ_func <- function(sw_norm_p_val, levene_p_val) {
  if (sw_norm_p_val <= 0.05) {
    distribution <- "Non-normal"
    stat_test <- "Mann-Whitney U Test"
  } else if (sw_norm_p_val > 0.05 & levene_p_val > 0.05) {
    distribution <- "Normal"
    stat_test <- "Independent T Test"
  } else {
    distribution <- "Normal"
    stat_test <- "Mann-Whitney U Test" # because Levene test less than 0.05 
  }
  new_vec <- c(distribution, stat_test) # make a vector of the names 
  return(new_vec)
}

# Inferential and descriptive statistics  
# This function takes the data in wide format, the columns to analyze as a number, if a t-test can be used (as a binar 0 or 1)
# and if the groups are dependent or not as a string. It then runs the appropriate test (t-test or Mann-Whitney U test) 
# and returns the p value as a numeric value. 
inf_stats_func <- function(wide_data, cols_to_analyze, norm_test_p_val, dep_or_ind) {
  if (dep_or_ind == "dep") {
    pair = TRUE
  } else {
    pair = FALSE
  }
  if (norm_test_p_val == 0) {
    test_p_val <- wilcox.test(wide_data[,cols_to_analyze] ~ wide_data$Group, paired = pair)$p.value
  } else {
    test_p_val <- t.test(wide_data[,cols_to_analyze]~wide_data$Group, paired = pair)$p.value
  }
  return(test_p_val)
}

# This function takes the p value from the inferential statistical test and returns a categorical variable of 
# if it is significant or not - note, significance in this case deemed as <= 0.05. 
sign_func <- function(inf_stats_p) {
  if (inf_stats_p <= 0.05) {
    group_sig <- "Significant"
  } else {
    group_sig <- "No Difference"
  }
  return(group_sig)
}


# This function takes a subset from a single groups in the data and runs descriptive statistics on the solumn of interest. 
# It returns a vector of the descriptive statistics. Note - The vectors first 9 values are 0's since the descriptvie statistics 
# goes at the bottom of the table. There is a more eluoquent way to do this, but for now this works. 
desc_stats_func <- function(group_subset, cols_to_analyze) {
  group_mean <- mean(group_subset[,cols_to_analyze]) # mean 
  group_sd <- sd(group_subset[,cols_to_analyze]) # standard deviation
  group_se <- sd(group_subset[,cols_to_analyze])/sqrt(length(group_subset)) # standard error 
  group_median <- median(group_subset[,cols_to_analyze]) # median 
  group_low_quart <- summary(group_subset[,cols_to_analyze])[2] # lower 
  group_upp_quart <- summary(group_subset[,cols_to_analyze])[5] # upper 
  return(desc_stats_vec <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, group_mean, group_sd, group_se, group_median, group_low_quart, group_upp_quart)) 
}

# This function calls on a bunch of the other functions created before to actually fill the table. So be careful that 
# you have run previous functions when using this one. It takes that data in wide format and the number of the column (biomarker) of interest
# It returns the table that it creates 
fill_table_func <- function(og_data, biomarker_col_num) {
  biomarker_name <- colnames(og_data)[biomarker_col_num] # get the name of the biomarker of interest
  sum_table <- skeleton_table_func(og_data, biomarker_name) # make the skeleton table by calling skeleton function
  sw_p_val <- round(norm_SW_test_func(og_data, biomarker_col_num), 4) # call funcrtion for p value for shapiro wilk test, round to 4 digits  
  lev_p_val <- round(norm_Lev_test_func(og_data, biomarker_col_num), 4) # call levene function, round 
  norm_p_val <- can_t_test_be_used(lev_p_val, sw_p_val) # determine if a t-test can be run (both shapiro wilk and levene must have p values > 0.05)
  sum_table[3,2:3] <- sw_p_val # update shapiro p value 
  sum_table[4,2:3] <- inf_test_typ_func(sw_p_val, lev_p_val)[1] # distribution name 
  sum_table[6,2:3] <- round(norm_Lev_test_func(og_data, biomarker_col_num), 4) # levene p-value 
  sum_table[7,2:3] <- inf_test_typ_func(sw_p_val, lev_p_val)[2] # stat test name 
  inf_stats_p <- round(inf_stats_func(og_data, biomarker_col_num, norm_p_val, "ind"), 4) # run inferential statistics
  sum_table[8,2:3] <- inf_stats_p # update the inferential stats p value in the table 
  sum_table[9,2:3] <- sign_func(inf_stats_p) # update if the differences are significant or not 
  # subset the data into their groups
  group_names <- unique(og_data$Group) # determine the group names 
  group1_subset <- og_data[which(og_data$Group == group_names[1]),] # subset the data based on the 2 dependent variables (2 groups)
  group2_subset <- og_data[which(og_data$Group == group_names[2]),]
  # put in descriptive stats for both groups - call on desc stats funciton 
  group1_desc_stats_vec <- round(desc_stats_func(group1_subset, biomarker_col_num), 1) # do the descirptive stats on each of the groups 
  group2_desc_stats_vec <- round(desc_stats_func(group2_subset, biomarker_col_num), 1)
  for (i in 10:15) { # don't put seq here, because then it will start at 1 
    sum_table[i,2] <- group1_desc_stats_vec[i] # put the descriptive stats in the table, use a loop to do it quickl with the vector 
    sum_table[i,3] <- group2_desc_stats_vec[i]
  }
  return(sum_table) # return the filled out table 
}


# MAIN PROGRAM: 
# All functions above must be run for this to work

# Some housekeeping values: 
no_cols <- dim(og_data)[2] # numnber of columns in OG data
no_rows <- dim(og_data)[1] # number of rows in OG data 

# data in long format if needed 
# gather requires tidyr package 
og_data_long <- gather(og_data, biomarker, value, 3:no_cols, factor_key = TRUE) 

# biomarker choices - these variables will be used multiple times later on, so just assigned them at the top 
# What data user wants to analyze (all, just inflammation, just a single variable, etc.)
header_names <- colnames(og_data)
biomarker_names <- header_names[-c(1:2)] # remove the first 2, since they are not biomarkers 

# We want to first ask the user what data they want to analyze and if they don't choose the given options
# it will continue to ask them until they choose a valid option. 
first_choice <- first_analysis_choice_func() # first get an original choice 
while (first_choice != 1 | first_choice != 2) { # it will go through this while loop until the coniditions in it are met 
  if (first_choice == 1 || first_choice == 2) { # so if the choice is valis (1 or 2), 
    break # the loop ands and nothing is done 
  } else { # otherwise, 
  print("That is not a valid option.") # it prints a warning message 
  first_choice <- first_analysis_choice_func() # and asks them again with an updated response for the user choice 
  }
}

# Large Id/else statment for the user either wanting to analyze ALL the data, or just a single biomarker 
if (first_choice == 1) { # If they want to analyze all the data 
  # do all of them  
  for (i in 3:no_cols) { # for all of the different biomarkers, 
    sum_table <- fill_table_func(og_data, i) # make a summary table 
    biomarker_name <- colnames(og_data)[i] 
    # these are for summary statements 
    if (norm_SW_test_func(og_data, i) <= 0.05) {  # this can be done more eluoqunetly, but running low on time for this project 
      print(paste(biomarker_name, ": (median[IQR]: ", sum_table[13,3], "[", sum_table[14,3], ",", sum_table[15,3], "] vs ", sum_table[13,2], "[", sum_table[14,2], ",", sum_table[15,2], "])", sep = ""))
    } else if (norm_Lev_test_func(og_data, i) <= 0.05) { 
      print(paste(biomarker_name, ": (median[IQR]: ", sum_table[13,3], "[", sum_table[14,3], ",", sum_table[15,3], "] vs ", sum_table[13,2], "[", sum_table[14,2], ",", sum_table[15,2], "])", sep = ""))
    } else {
      print(paste(biomarker_name, ": (mean±SEM: ",sum_table[10,3],"±",sum_table[12,3]," vs ",sum_table[10,2],"±",sum_table[12,2],")", sep = "")) # sep removes white space between entries 
    }
    write.csv(x = sum_table, file = paste(biomarker_name,"_summary_table.csv", sep = "")) # this will write to separate ones, but we maybe want to append to single csv....any way to do this? tbale loses formatting...Tried and never got to work 
  }
 
  # Next make the graphs 
  # First ask user what type of graph they want, also uses a while loop until the user selects a valid option 
  graph_choice <- graph_type_choice_func( )
  while (graph_choice != 1 || graph_choice != 2) {
    if (graph_choice == 1 || graph_choice == 2) {
      break 
    } else {
      print("That is not a valid option.")
      graph_choice <- graph_type_choice_func( ) 
    }
  }
  

  # Graphs the correct graph based on user repsonse 
  # note - data must be in long here!
  if (graph_choice == 1) { # if statement so that you can make appropriate graphs 
    my_plot <- ggplot(data = og_data_long, aes(x = Group, y = value)) + # make sure data is in long format for this 
      geom_bar(stat = "summary") + # you have to use identity here because geom_bar expects only x or y, not both 
      labs(title = "Biomarker Levels",  y = "Relative Abundance (AU)") +
      facet_wrap(~biomarker, scales = "free_y") # facetwrap by the biomarkers of interest 
    file_name <- paste(data_label, "_all_data_bar_graph.pdf", sep = "")
  } else { # make a dot plot 
    my_plot <- ggplot(data = og_data_long, aes(x = Group, y = value)) + 
      geom_point() + 
      labs(title = "Biomarker Levels",  y = "Relative Abundance (AU)") +
      facet_wrap(~biomarker, scales = "free_y") # make the scales free for each panel
    file_name <- paste(data_label, "_all_data_dot_plot.pdf", sep = "")
  }
  
  # To save the graph:
  # open a PDF
  pdf(file_name)
  # print it 
  print(my_plot)
  # close the PDF
  dev.off()
  
} else if (first_choice == 2) { # If the user wants a single biomarker, 
  biomarker_choice <- biomarker_choices_func(biomarker_names) # give them the list of choices and store their option 
  # if the biomarker is outside of the number of choices given, use a while loop to keep asking them for a valid option 
  while (biomarker_choice < 1 | biomarker_choice > length(biomarker_names)) { 
    biomarker_choice <- biomarker_choices_func(biomarker_names)
    if (biomarker_choice > 1 & biomarker_choice < length(biomarker_names)) {
      break 
    } else {
      print("That is not a valid option.")
      biomarker_choice <- biomarker_choices_func(biomarker_names) 
    }
  }
  
  biomarker_col_num <- biomarker_choice + 2 # the actual  column number is 2 higher than the choice number since we got rid of group and subject column in the hcoice list 
  sum_table <- fill_table_func(og_data, biomarker_col_num) # call the main function that fills the table 
  biomarker_name <- colnames(og_data)[biomarker_col_num] # get the specific biomarker name to put in saved file 
  write.csv(x = sum_table, file = paste(biomarker_name, "_summary_table.csv", sep = "")) # write the table to csv
 
  # ask graph choice, keep asking until they get it right 
  graph_choice <- graph_type_choice_func( )
  while (graph_choice != 1 || graph_choice != 2) {
    if (graph_choice == 1 || graph_choice == 2) {
      break 
    } else {
      print("That is not a valid option.")
      graph_choice <- graph_type_choice_func( ) 
    }
  }
  
  # have to subset the data into the speicfic marker the user wants 
  marker_subset_wide <- og_data[,c(1:2,biomarker_col_num)] # subset data into specific marke r
  marker_subset_long <- gather(marker_subset_wide, biomarker, value, 3, factor_key = TRUE)
  
  # graph appropriate marker 
  if (graph_choice == 1){ # if statement so that you can make appropriate graphs 
    my_plot <- ggplot(data = marker_subset_long, aes(x = Group, y = value)) + # make sure data is in long format for this 
      geom_bar(stat = "summary") + # you have to use identity here because geom_bar expects only x or y, not both 
      labs(title = "Biomarker Levels",  y = "Relative Abundance (AU)") +
      facet_wrap(~biomarker, scales = "free_y") # facetwrap by the biomarkers of interest 
    file_name <- paste(data_label, "_", biomarker_name, "_bar_graph.pdf", sep = "")
  } else {
    my_plot <- ggplot(data = marker_subset_long, aes(x = Group, y = value)) + 
      geom_point() + 
      labs(title = "Biomarker Levels",  y = "Relative Abundance (AU)") +
      facet_wrap(~biomarker, scales = "free_y") # make the scales free for each panel 
    file_name <- paste(data_label, "_", biomarker_name, "_dot_plot.pdf", sep = "")
  }
  
  # save graph 
  pdf(file_name)
  print(my_plot) 
  dev.off()
  
  # finally print summary statment: 
  if (norm_SW_test_func(og_data, biomarker_col_num) <= 0.05) { # this can be done more eluoqunetly 
    print(paste(biomarker_name, ": (median[IQR]: ", sum_table[13,3], "[", sum_table[14,3], ",", sum_table[15,3], "] vs ", sum_table[13,2], "[", sum_table[14,2], ",", sum_table[15,2], "])", sep = ""))
  } else if (norm_Lev_test_func(og_data, i) <= 0.05) {
    print(paste(biomarker_name, ": (median[IQR]: ", sum_table[13,3], "[", sum_table[14,3], ",", sum_table[15,3], "] vs ", sum_table[13,2], "[", sum_table[14,2], ",", sum_table[15,2], "])", sep = ""))
  } else {
    print(paste(biomarker_name, ": (mean±SEM: ",sum_table[10,3],"±",sum_table[12,3]," vs ",sum_table[10,2],"±",sum_table[12,2],")", sep = "")) # sep removes white space between entries 
  }
}


