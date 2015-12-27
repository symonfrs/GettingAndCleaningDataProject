==================================================================
Coursera Course: Getting and Cleansing Data - Project
==================================================================
Overview:
========
The objective of the above project is to extract and tidy specified portions of the Human Activity Recognition Using Smartphones Dataset (Version 1.0).
The goal is to prepare tidy data that can be used for later analyses. The input raw data set is available from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
A full description this raw data is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  
This README file describes how an R script "run_analysis.R" created for extracting and tidying the data works. 
==================================================================

Input Data:
==========
The input data comprises data from experiments carried out with a group of 30 volunteers (Subjects) within an age bracket of 19-48 years performing 6 Activities 
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset contains a vector of features (normalized 
and bounded within [-1,1]) obtained by calculating variables from the time and frequency domainhas and is randomly partitioned into two sets, where 70% of the 
volunteers was selected for generating the training data and 30% the test data. 

Input data available for each record includes:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The input dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
   Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Project scope: 

- The scope of this project however is limited to extraction of features related to measurements on the mean and standard deviation. As a results, the data
  corresponding to Inertial Signals is not used in the extraction and tidying process.

Processing Steps in "run_analysis.R":
=====================================
STEP 1: Extraction of Raw data into R:

	# Extraction of test data
		subject_test = read.table("test\\subject_test.txt")
		X_test = read.table("test\\X_test.txt")
		Y_test = read.table("test\\Y_test.txt")

	# Extraction of training data
		subject_train = read.table("train\\subject_train.txt")
		X_train = read.table("train\\X_train.txt")
		Y_train = read.table("train\\Y_train.txt")

	# Extraction of supporting metadata
		featurenames <- read.table("features.txt", col.names=c("featureId", "feature"))
		activities <- read.table("activity_labels.txt", col.names=c("activityId", "activity"))

	# Extraction of featurenames corresponding to Mean and Standard Deviation of measurements	
		requiredfeatures <- grep("-mean\\(\\)|-std\\(\\)",featurenames$feature)

STEP 2: Merging of test and training data:

	# Merging of test and training data and then naming them
		subject <- rbind(subject_test, subject_train)
		names(subject) <- "subject"
		X <- rbind(X_test, X_train)
		X <- X[, requiredfeatures]
		names(X) <- gsub("\\(|\\)", "", featurenames$feature[requiredfeatures])
		Y <- rbind(Y_test, Y_train)
		names(Y) = "activityId"

	# Combining Subject, Variable data and Activity data fields
		completedata<-cbind(subject,Y,X)

STEP 3: Replacing activity ID with activity names:

	# Convert activity Id field to factor and replace with activity names
		completedata$activityId <- as.character(completedata$activityId)
		for (i in 1:6){
  		completedata$activityId[completedata$activityId == i] <- as.character(activities[i,2])
		}
		names(completedata)<-gsub("activityId", "activity", names(completedata))

STEP 4: Replacing feature names with more descriptive variable names:

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

STEP 5: Creating and writing the Tidy dataset:
	# create a dataset with the average of each variable for each activity and each subject
		library(data.table)
		DT <- data.table(completedata)
		DTCalc<- DT[, lapply(.SD,mean), by=c("subject", "activity")]

	# Sort the dataset and write it to a text file
		tidydata <- DTCalc[order(DTCalc$subject,DTCalc$activity),]
		write.table(tidydata, "tidy_data.txt",row.name=FALSE)

==================================================================================================