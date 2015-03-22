# run_analysis.R
# dmdata101

library(dplyr)

### QUESTION 1 ###

# Set base directory for tiles
dir='./'

# read variable info from 'features.txt'
file=paste(dir,'features.txt',sep='')
listvar=read.table(file,as.is=c(1,2))

# read test set
file=paste(dir,'test/X_test.txt',sep='')
data_test=read.table(file)
# assign row names to the dataset
names(data_test)=listvar[,2]
# create new raw with info 'test' to label this data as 'test' in the future merged table
data_test$label=rep('test',2947)

# read training set
file=paste(dir,'train/X_train.txt',sep='')
data_train=read.table(file)
# assign row names to the dataset
names(data_train)=listvar[,2]
# create new raw with info 'train' to label this data as 'train' in the future merged table
data_train$label=rep('train',7352)

# keep listvar in sync with data info
listvar=rbind(listvar,list(562,'label'))


### QUESTION 1 ###
# Merge both data sets
datamerged=rbind(data_test,data_train)

# clean memory
rm(data_train,data_test)

### QUESTION 2 ###
# According to file 'features_info.txt',
#  names of the mean for each variable end with 'mean()' and
#  names of the std dev for each variable end with 'std()'
# So we're selecting all varnames from 'listvar' that contain either mean() or std()
# and selecting only these in the new data_extract table.

names(listvar)=c('row','varname')
l1=grep('std()',listvar$varname)
l2=grep('mean()',listvar$varname)
l=sort(c(l1,l2))
datameanstd=datamerged[,l] # Subset of datamerged containing only std or mean variables


### QUESTION 3 ###
# Open the file containing activity labels
file=paste(dir,'activity_labels.txt',sep='')
activities=read.table(file)

# Open the file linking activity to data points (for test data)
file=paste(dir,'test/y_test.txt',sep='')
activitytest=read.table(file,colClasses='factor',col.names='Activity')

# Open the file linking activity to data points (for train data)
file=paste(dir,'train/y_train.txt',sep='')
activitytrain=read.table(file,colClasses='factor',col.names='Activity')

# Bind data, test then train
activity=rbind(activitytest,activitytrain)

# Adds 'Activity' row to datameanstd
datameanstdactivity=cbind(datameanstd,activity)

# Rename levels for the 'Activity' Factor to make them 'Descriptive'
levels(datameanstdactivity$Activity)=activities[,2] ## ANSWER TO QUESTION 3 

### QUESTION 4 ###

oldnames=names(datameanstdactivity)
newnames=gsub("[[:punct:]]", "", oldnames) # removes all punctuation in names
names(datameanstdactivity)=newnames

### QUESTION 5 ###
# Open the file linking subjects to data points (for test data)
file=paste(dir,'test/subject_test.txt',sep='')
subjecttest=read.table(file,colClasses='factor',col.names='Subject')

# Open the file linking activity to data points (for train data)
file=paste(dir,'train/subject_train.txt',sep='')
subjecttrain=read.table(file,colClasses='factor',col.names='Subject')

# Bind data, test then train
subject=rbind(subjecttest,subjecttrain)

# Adds 'Subject' row to datameanstdactivity
data=cbind(datameanstdactivity,subject)

# Using dplyr to group data by Subject and Activity
group=group_by(data,Subject,Activity)
tidyfinaltable=summarise_each(group,funs(mean))
write.table(tidyfinaltable,file='finaltable.txt',row.names=FALSE)
closeAllConnections()

print(tidyfinaltable)