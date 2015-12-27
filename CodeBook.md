#CodeBook

##Overview

This code book describes the input and output data variables and the transformations performed to extract and clean specified portions of the Human Activity Recognition Using 
Smartphones Dataset (Version 1.0) as part of the Coursera Getting and Cleaning Data Course project. The goal is to prepare tidy data that can be used for later analyses.

##The Input Data

The input raw data set is available from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. A full description this raw 
data is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

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
- 'features_info.txt': Shows information about the 561 variables used on the feature vector.
- 'features.txt': List of all 561 features.
- 'activity_labels.txt': Links the 6 class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
   Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

##Transformation details

The transformation of input data to obtain the output Tidy data involves the following steps:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive activity names.
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The R script "run_analysis.R" implements the above transformation through the following steps:
-STEP 1: Extraction of Raw data into R:
	-Extraction of test data
	-Extraction of training data
	-Extraction of supporting metadata including featurenames and activities
	-Extraction of featurenames corresponding to Mean and Standard Deviation of measurements (66 feature variables)	
-STEP 2: Merging of test and training data:
	-Merging of test and training data pertaining to Subject, Variable data and Activity and then naming them
	-Combining Subject, Variable data and Activity data fields
-STEP 3: Replacing activity ID with activity names:
	-Convert activity Id field to factor and replace with activity names
-STEP 4: Replacing feature names with more descriptive variable names:
	-Replace feature names with more descriptive variable names in the Complete dataset
	e.g. tBody is replaced with TimeBody and fBody is replaced with FrequencyBody,etc.	
-STEP 5: Creating and writing the Tidy dataset:
	# create a dataset with the average of each variable for each activity and each subject
	# Sort the dataset and write it to a text file

##Description of Output variables

The output comprises a data frame with 180 observations on 68 variables written in a text file "Tidy_data.txt". The values of each of the feature measurement
variables in the Tidy data represent AVERAGE of each Variable for each ACTIVITY and each SUBJECT. 

The UNIT of measurement for all feature variables is number of times of g (acceleration due to gravity). e.g. 1.0 g = 9.81 m/s2

The description of the 68 variables are as under:
	
	-subject  - a numeric vector identifying the volumteer (1 to 30) carrying out the activity.
	-activity - a factor with 6 levels LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS and WALKING_UPSTAIRS identifying the activity being measured
    	
	-TimeBodyAccelerometer.Mean.X - a numeric vector indicating mean of body accelerometer measurement in X direction in time domain.
    	-TimeBodyAccelerometer.Mean.Y - a numeric vector indicating mean of body accelerometer measurement in Y direction in time domain.
    	-TimeBodyAccelerometer.Mean.Z - a numeric vector indicating mean of body accelerometer measurement in Z direction in time domain.
    	
	-TimeBodyAccelerometer.Standard_Deviation.X - a numeric vector indicating Standard deviation of body accelerometer measurement in X direction in time domain.
    	-TimeBodyAccelerometer.Standard_Deviation.Y - a numeric vector indicating Standard deviation of body accelerometer measurement in Y direction in time domain.
    	-TimeBodyAccelerometer.Standard_Deviation.Z - a numeric vector indicating Standard deviation of body accelerometer measurement in Z direction in time domain.
    	
	-TimeGravityAccelerometer.Mean.X - a numeric vector indicating mean of gravity accelerometer measurement in X direction in time domain.
    	-TimeGravityAccelerometer.Mean.Y - a numeric vector indicating mean of gravity accelerometer measurement in Y direction in time domain.
    	-TimeGravityAccelerometer.Mean.Z - a numeric vector indicating mean of gravity accelerometer measurement in Z direction in time domain.
    		
	-TimeGravityAccelerometer.Standard_Deviation.X - a numeric vector indicating Standard deviation of gravity accelerometer measurement in X direction in time domain.
    	-TimeGravityAccelerometer.Standard_Deviation.Y - a numeric vector indicating Standard deviation of gravity accelerometer measurement in Y direction in time domain.
    	-TimeGravityAccelerometer.Standard_Deviation.Z - a numeric vector indicating Standard deviation of gravity accelerometer measurement in Z direction in time domain.
    	
	-TimeBodyAccelerometerJerk.Mean.X - a numeric vector indicating mean of body jerk accelerometer measurement in X direction in time domain.
    	-TimeBodyAccelerometerJerk.Mean.Y - a numeric vector indicating mean of body jerk accelerometer measurement in Y direction in time domain.
    	-TimeBodyAccelerometerJerk.Mean.Z - a numeric vector indicating mean of body jerk accelerometer measurement in Z direction in time domain.
    	
	-TimeBodyAccelerometerJerk.Standard_Deviation.X - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in X direction in time domain.
    	-TimeBodyAccelerometerJerk.Standard_Deviation.Y - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in Y direction in time domain.
    	-TimeBodyAccelerometerJerk.Standard_Deviation.Z - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in Z direction in time domain.
    	
	-TimeBodyGyroscope.Mean.X - a numeric vector indicating mean of body gyroscope measurement in X direction in time domain.
    	-TimeBodyGyroscope.Mean.Y - a numeric vector indicating mean of body gyroscope measurement in Y direction in time domain.
    	-TimeBodyGyroscope.Mean.Z - a numeric vector indicating mean of body gyroscope measurement in Z direction in time domain.
    	
	-TimeBodyGyroscope.Standard_Deviation.X - a numeric vector indicating Standard deviation of body gyroscope measurement in X direction in time domain.
    	-TimeBodyGyroscope.Standard_Deviation.Y - a numeric vector indicating Standard deviation of body gyroscope measurement in Y direction in time domain.
    	-TimeBodyGyroscope.Standard_Deviation.Z - a numeric vector indicating Standard deviation of body gyroscope measurement in Z direction in time domain.
    	
	-TimeBodyGyroscopeJerk.Mean.X - a numeric vector indicating mean of body jerk gyroscope measurement in X direction in time domain.
    	-TimeBodyGyroscopeJerk.Mean.Y - a numeric vector indicating mean of body jerk gyroscope measurement in Y direction in time domain.
    	-TimeBodyGyroscopeJerk.Mean.Z - a numeric vector indicating mean of body jerk gyroscope measurement in Z direction in time domain.
    	
	-TimeBodyGyroscopeJerk.Standard_Deviation.X - a numeric vector indicating Standard deviation of body jerk gyroscope measurement in X direction in time domain.
    	-TimeBodyGyroscopeJerk.Standard_Deviation.Y - a numeric vector indicating Standard deviation of body jerk gyroscope measurement in Y direction in time domain.
    	-TimeBodyGyroscopeJerk.Standard_Deviation.Z - a numeric vector indicating Standard deviation of body jerk gyroscope measurement in Z direction in time domain.
    	
	-TimeBodyAccelerometer.Mean - a numeric vector indicating mean of body accelerometer measurement in time domain.
    	-TimeBodyAccelerometer.Standard_Deviation - a numeric vector indicating Standard deviation of body accelerometer measurement in time domain.
    	
	-TimeGravityAccelerometer.Mean - a numeric vector indicating mean of gravity accelerometer measurement in time domain.
    	-TimeGravityAccelerometer.Standard_Deviation - a numeric vector indicating Standard deviation of gravity accelerometer measurement in time domain.
    	
	-TimeBodyAccelerometerJerk.Mean - a numeric vector indicating mean of body jerk accelerometer measurement in time domain.
    	-TimeBodyAccelerometerJerk.Standard_Deviation - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in time domain.
    	
	-TimeBodyGyroscope.Mean - a numeric vector indicating mean of body gyroscope measurement in time domain.
    	-TimeBodyGyroscope.Standard_Deviation - a numeric vector indicating Standard deviation of body gyroscope measurement in time domain.
    	
	-TimeBodyGyroscopeJerk.Mean - a numeric vector indicating mean of body jerk gyroscope measurement in time domain.
    	-TimeBodyGyroscopeJerk.Standard_Deviation - a numeric vector indicating Standard deviation of body jerk gyroscope measurement in time domain.
    	
	-FrequencyBodyAccelerometer.Mean.X - a numeric vector indicating mean of body accelerometer measurement in X direction in frequency domain.
    	-FrequencyBodyAccelerometer.Mean.Y - a numeric vector indicating mean of body accelerometer measurement in Y direction in frequency domain.
    	-FrequencyBodyAccelerometer.Mean.Z - a numeric vector indicating mean of body accelerometer measurement in Z direction in frequency domain.
    	
	-FrequencyBodyAccelerometer.Standard_Deviation.X - a numeric vector indicating Standard deviation of body accelerometer measurement in X direction in frequency domain.
    	-FrequencyBodyAccelerometer.Standard_Deviation.Y - a numeric vector indicating Standard deviation of body accelerometer measurement in Y direction in frequency domain.
    	-FrequencyBodyAccelerometer.Standard_Deviation.Z - a numeric vector indicating Standard deviation of body accelerometer measurement in Z direction in frequency domain.
    	
	-FrequencyBodyAccelerometerJerk.Mean.X - a numeric vector indicating mean of body jerk accelerometer measurement in X direction in frequency domain.
    	-FrequencyBodyAccelerometerJerk.Mean.Y - a numeric vector indicating mean of body jerk accelerometer measurement in Y direction in frequency domain.
    	-FrequencyBodyAccelerometerJerk.Mean.Z - a numeric vector indicating mean of body jerk accelerometer measurement in Z direction in frequency domain.
    	
	-FrequencyBodyAccelerometerJerk.Standard_Deviation.X - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in X direction in frequency domain.
    	-FrequencyBodyAccelerometerJerk.Standard_Deviation.Y - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in Y direction in frequency domain.
    	-FrequencyBodyAccelerometerJerk.Standard_Deviation.Z - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in Z direction in frequency domain.
    	
	-FrequencyBodyGyroscope.Mean.X - a numeric vector indicating mean of body gyroscope measurement in X direction in frequency domain.
    	-FrequencyBodyGyroscope.Mean.Y - a numeric vector indicating mean of body gyroscope measurement in Y direction in frequency domain.
    	-FrequencyBodyGyroscope.Mean.Z - a numeric vector indicating mean of body gyroscope measurement in Z direction in frequency domain.
    	
	-FrequencyBodyGyroscope.Standard_Deviation.X - a numeric vector indicating Standard deviation of body gyroscope measurement in X direction in frequency domain.
    	-FrequencyBodyGyroscope.Standard_Deviation.Y - a numeric vector indicating Standard deviation of body gyroscope measurement in Y direction in frequency domain.
    	-FrequencyBodyGyroscope.Standard_Deviation.Z - a numeric vector indicating Standard deviation of body gyroscope measurement in Z direction in frequency domain.
    		
	-FrequencyBodyAccelerometer.Mean - a numeric vector indicating mean of body accelerometer measurement in frequency domain.
    	-FrequencyBodyAccelerometer.Standard_Deviation - a numeric vector indicating Standard deviation of body accelerometer measurement in frequency domain.
    		
	-FrequencyBodyAccelerometerJerk.Mean - a numeric vector indicating mean of body jerk accelerometer measurement in frequency domain.
    	-FrequencyBodyAccelerometerJerk.Standard_Deviation - a numeric vector indicating Standard deviation of body jerk accelerometer measurement in frequency domain.
    	
	-FrequencyBodyGyroscope.Mean - a numeric vector indicating mean of body gyroscope measurement in frequency domain.
    	-FrequencyBodyGyroscope.Standard_Deviation - a numeric vector indicating Standard deviation of body gyroscope measurement in frequency domain.
    	
	-FrequencyBodyGyroscopeJerk.Mean - a numeric vector indicating mean of body jerk gyroscope measurement in frequency domain.
    	-FrequencyBodyGyroscopeJerk.Standard_Deviation - a numeric vector indicating Standard deviation of body jerk gyroscope measurement in frequency domain.

##Additional references

The additional references include "README.md" supplied with this code book and the below publications:

1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 

2. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra, Jorge L. Reyes-Ortiz. Energy Efficient Smartphone-Based Activity Recognition using Fixed-Point 
Arithmetic. Journal of Universal Computer Science. Special Issue in Ambient Assisted Living: Home Care. Volume 19, Issue 9. May 2013

3. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
Support Vector Machine. 4th International Workshop of Ambient Assited Living, IWAAL 2012, Vitoria-Gasteiz, Spain, December 3-5, 2012. Proceedings. Lecture Notes 
in Computer Science 2012, pp 216-223. 

4. Jorge Luis Reyes-Ortiz, Alessandro Ghio, Xavier Parra-Llanas, Davide Anguita, Joan Cabestany, Andreu Català. Human Activity and Motion Disorder Recognition: 
Towards Smarter Interactive Cognitive Environments. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, 
ESANN 2013. Bruges, Belgium 24-26 April 2013.
 	


==================================================================================================