# get headers first by using the head command and flagging with -n to extract which line number and write it into new csv file 

head -n 1 PredPreyData.csv > PredPreySubset.csv

# then get the last 10 lines of original file using tail command, append it to the subset data we made in the previous command (use >> to append)  

tail PredPreyData.csv >> PredPreySubset.csv 

# use the cut command to just choose columns 2 through 4 and write it to csv file. 

cut -f 2-4 -d , PredPreySubset.csv > PredPreyFinal.csv