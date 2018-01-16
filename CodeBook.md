# Introduction

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data source

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Steps

### 1.- after unzip the data source the data sets have been load into memory following this convention:

features <- /features.txt

activityType <- /activity_labels.txt

subjectTrain <- /train/subject_train.txt

xTrain <- ./train/x_train.txt

yTrain <- /train/y_train.txt

subjectTest <- ./test/subject_test.txt

xTest <- /test/x_test.txt

yTest <- /test/y_test.txt

### 2.- The following names have been set for the names of each data set

activityType <- activityId , activityType

subjectTrain <- subjectId

yTrain <- activityId

subjectTest <- subjectId

yTest <- activityId

### 3.- A new pair of data sets have been created using the subjects, Y and X data sets for each folder (train and test)

train <- cbind(yTrain,subjectTrain,xTrain)

test <- cbind(yTest,subjectTest,xTest)

### 4.- train and test data set have been merged in a nw data set called Data

Data <- rbind(train,test)

### 5.- In order to create a more readable information some names have been renamed

"^t", "Time"

"^f", "Frequency"

"Acc", "Accelerometer"

"Gyro", "Gyroscope"

"Mag", "Magnitude"

"BodyBody", "Body"

"-std", "Standard"

"-mean", "Mean"

"AccMag","AccMagnitude"

"\\()", ""

### 6.- A new data set named tidy_data has been created to get the average value for each activity an subject and as exporte to tidy_data.txt file

tidy_data  <- aggregate(. ~subjectId + activityId, Data, mean)

write.table(tidy_data, "tidy_data.txt", row.names = FALSE, quote = FALSE)

This file is under UCI HAR Dataset folder

