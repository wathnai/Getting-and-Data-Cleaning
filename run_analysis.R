# Here are the data for the project:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#SET Working directory
setwd("C:/users/sanchj67/Documents/Data_Science/Getting and Cleaning Data/")
dir.create("UCI HAR Dataset")

#Download the data and unzipping the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "Data.zip"
download.file(url, dest)

#unzip the file and setting the Working directory
zipF <-"C:/users/sanchj67/Documents/Data_Science/Getting and Cleaning Data/Data.zip"
outDir<-"C:/users/sanchj67/Documents/Data_Science/Getting and Cleaning Data"
unzip(zipF, exdir=outDir)
setwd("C:/users/sanchj67/Documents/Data_Science/Getting and Cleaning Data/UCI HAR Dataset")
getwd()

# Reading data files
features <- read.table('./features.txt',header=FALSE)
activityType <- read.table('./activity_labels.txt',header=FALSE)
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)
xTrain <- read.table('./train/x_train.txt',header=FALSE)
yTrain <- read.table('./train/y_train.txt',header=FALSE)
subjectTest <- read.table('./test/subject_test.txt',header=FALSE)
xTest <- read.table('./test/x_test.txt',header=FALSE)
yTest <- read.table('./test/y_test.txt',header=FALSE)

#aSSigning new names for the columns
colnames(activityType) <- c('activityId','activityType')
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2] 
colnames(yTrain) <- "activityId"
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

#Merging Data to create the two data sets
train <- cbind(yTrain,subjectTrain,xTrain)
test <- cbind(yTest,subjectTest,xTest)

# checking structure View(train) View(test)

# Merge train and test data sets
Data <- rbind(train,test)

# Renaming labels to be descriptive

names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "frequency", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data) <- gsub("-std", "Standard", names(Data))
names(Data) <- gsub("-mean", "Mean", names(Data))
names(Data) <- gsub("AccMag","AccMagnitude",names(Data))
names(Data) <- gsub("\\()", "", names(Data)) # Special character
names(Data) <- gsub("time", "Time", names(Data)) #should be done in the first renaming code line, line 59
names(Data) <- gsub("frecuency", "Frecuency", names(Data)) #should be done in the second renaming code line, liine 60


# Create a second, independent tidy data set with the average of each variable for each activity and each subject. 


tidy_data  <- aggregate(. ~subjectId + activityId, Data, mean)
#View(tidy_data)

write.table(tidy_data, "tidy_data.txt", row.names = FALSE, quote = FALSE)