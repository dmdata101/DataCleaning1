
CodeBook file
Course Project Coursera 'Getting and cleaning data'
Assignment by dmdata101


### QUESTION 1: Create one data set

VARIABLES

listvar: data.table containing the complete list of variables as provided.

datamerged: data.table containing the merged data.
 comment: data is merged in this order 'test' first, and then 'train'
 comment: datamerged also contains a variable $label, a factor with two levels describing whether data is taken during 'train' or 'test'
 
TEMPORARY VARIABLES

data_train and data_test are data.table read from the files/

OPERATIONS/TRANSFORMATIONS

- No data transformation is performed.
- Data is merged in this order: 'test' first and then 'train'
- A variable $label is added to the datamerged data.table.

### QUESTION 2: Extract only mean and std measurements

VARIABLES

listvar: data.table containing the complete list of variables as provided.
 listvar contains two fields: $row and $varname

l1 = list of listvar$varname for standard deviation variables
l2 = list of listvar$varname for mean variables
l = sorted list of listvar$varname for standard deviation AND mean variable

datameanstd = subset of data.table containing only standard dev or mean variables



### QUESTION 3: Descriptive activity name

VARIABLES

activities : data.table extracting the 'activity_labels.txt' file.
 activities are a factor of six elements

activitytest : data.table extracting the activity info for test data
activitytrain : data.table extracting the activity info for train data
activity : data.table containnig activity info for test and train data

datameanstdactivity: activity info is added to datameanstd variable to include activity info
datameanstdactivity is the answer to question 3

OPERATIONS/TRANSFORMATIONS

Activity info is coded as a factor: line 76 renames the levels to include 'descriptive' names as descrined in file 'activity_labels.txt'


### QUESTION 4

OPERATIONS / TRANSFORMATIONS

Descriptive variable names are extracted from existing variable names by removing the punctuation marks.
This is done using the 'gsub' function on line 81

### QUESTION 5 : Subject information is added to the data

VARIABLES
subjecttest : data.table contains subject info for the test phase extracted from the file provided
subjecttrain : data.table contains subject info for the train phase extracted from the file provided
subject : data.table containing subject info for both phases

data : subject information is added to datameanstdactivity on line 97.
data is the anser to 

tidyfinaltable : final table and result (see 'OPERATIONS')

OPERATIONS

information from data.table 'data' is grouped by Subject and Activity on line 100

function 'summarise_each' summarizes all tables NOT previously grouped, performing the operation 'mean'

FINAL TABLE
tidyfinaltable contains the final answer to this test: average of all available measures grouped by Subject and Activity
col1: Subject reference
col2: Activity reference (using descriptive activity name)
col3 and above: variable averaged by Subject and Activity.