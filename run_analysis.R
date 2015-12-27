# Getting and Cleaning Data Course - PROJECT

# Analysis of Human Activity Recognition using Smartphones Data set

run_analysis <- function(){
  
# Setting Working directory
setwd("C:\\Users\\Symon\\coursera\\GettingAndCleaningDataProject")

# Extract test data
subject_test = read.table("HAR_data\\test\\subject_test.txt")
X_test = read.table("HAR_data\\test\\X_test.txt")
Y_test = read.table("HAR_data\\test\\Y_test.txt")

# Extract training data
subject_train = read.table("HAR_data\\train\\subject_train.txt")
X_train = read.table("HAR_data\\train\\X_train.txt")
Y_train = read.table("HAR_data\\train\\Y_train.txt")

# Extract supporting metadata
featurenames <- read.table("HAR_data\\features.txt", col.names=c("featureId", "feature"))
activities <- read.table("HAR_data\\activity_labels.txt", col.names=c("activityId", "activity"))
requiredfeatures <- grep("-mean\\(\\)|-std\\(\\)",featurenames$feature)

# Merge test and training data and then name them
subject <- rbind(subject_test, subject_train)
names(subject) <- "subject"
X <- rbind(X_test, X_train)
X <- X[, requiredfeatures]
names(X) <- gsub("\\(|\\)", "", featurenames$feature[requiredfeatures])
Y <- rbind(Y_test, Y_train)
names(Y) = "activityId"

# Combine Subject, Data and Activity data fields
completedata<-cbind(subject,Y,X)

# Convert activity Id field to factor and replace with activity names
completedata$activityId <- as.character(completedata$activityId)
for (i in 1:6){
  completedata$activityId[completedata$activityId == i] <- as.character(activities[i,2])
}
names(completedata)<-gsub("activityId", "activity", names(completedata))

# Replace feature names with more descriptive variable names in the Complete dataset
names(completedata)<-gsub("tBody", "TimeBody", names(completedata))
names(completedata)<-gsub("fBody", "FrequencyBody", names(completedata))
names(completedata)<-gsub("tGravity", "TimeGravity", names(completedata))
names(completedata)<-gsub("Acc", "Accelerometer", names(completedata))
names(completedata)<-gsub("Gyro", "Gyroscope", names(completedata))
names(completedata)<-gsub("Mag", "", names(completedata))
names(completedata)<-gsub("-mean", "-Mean", names(completedata))
names(completedata)<-gsub("-std", "-Standard_Deviation", names(completedata))
names(completedata)<-gsub("BodyBody", "Body", names(completedata))

# create a dataset with the average of each variable for each activity and each subject
library(data.table)
DT <- data.table(completedata)
DTCalc<- DT[, lapply(.SD,mean), by=c("subject", "activity")]
tidydata <- DTCalc[order(DTCalc$subject,DTCalc$activity),]
write.table(tidydata, "tidy_data.txt",row.name=FALSE)
}
