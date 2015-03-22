
File README.md
Project from dmdata101

Provided documents
1. run_analysis.R > R script containing all operations to complete the assignment, including creating the result file 'finaltable.txt'.
2. README.md > this file
3. CodeBook.md > CodeBook file, providing description of variables, data and operations performed.

Script description

Script 'run_analysis.R' works when it is in the same folder as folders 'test' and 'train'. 

*** QUESTION 1 

Lines 1-32 : Files are read:
  feature.txt -> to variable 'listvar' to create the list of all variables
  test/X_text.txt -> to variable data_test (data.table)
  train/X_train.txt -> to variable data_train (data.table)
  
  Names of variables in data_test and data_train are set to the contents of 'features.txt' in lines 19 and 27
  A variable $label is added, 2-level factor describing if the data is taken from the 'train' or 'test' files
  
Line 37 : data is merged to the data.frame variable 'datamerged'

> datamerged is the answer to question 1


*** QUESTION 2

Lines 49-52: Fields containing average or std deviation variables are selected using the 'grep' function on field names, on line 50 and 51.

Line 53: subset 'datameanstd' contains only variables requested in question 2.

> datameanstd is the answer to question 2

*** QUESTION 3

Lines 58-67 : Files containing the activity are read as factors.

Line 70 : Variable 'activity' contains the activities for all data (train and test)

Line 73 : Variable activity is added to data.frame 'datameanstd' to create data.frame datameanstdactivity

Line 76 : Levels in data.frame datameanstdactivity are renamed with the 'Descriptive' Activity names

> datameanstdactivity is the answer to question 3


*** QUESTION 4

Lines 80-82 : Puntuation marks are removed from variable names to make them more descriptive.

> datameanstdactivity is the answer to question 4


*** QUESTION 5

Lines 86-91 : Subject information is read from files in data.frames

Line 94 : Subject information is merged between 'test' and 'train' datasets

Line 97 : Subject information is added to complete data, creating the new data.table 'data'

Line 100 : 'data' is grouped by Subject and Activity

Line 101 : function 'summarise_each' performs the function 'mean' on all variables not previously grouped, in effect providing averages for every Activity and Subject in data.frame 'tidyfinaltable'.

> 'tidyfinaltable' is the final result of this assignment.

Line 102 : Creates the text file 'finaltable.txt' containing the requested result.