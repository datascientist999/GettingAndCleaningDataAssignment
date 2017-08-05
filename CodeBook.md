# R script

File "run_analysis.R" 
Steps are mentioned below

## 1. Merges the training and the test sets to create one data set.
	# Download and unzip data set
	# Read train tables
	# Read test tables
	# Read features table
	# Read activity labels
	# Add columns
	# Merge all data
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	# Extract mean and standard deviation

## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
	# Data set with descriptive variable names

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	# Second independent tidy data set with the average of each variable for each activity and each subject


# Variables

fileUrl - URL for data set file download

x_train - Read X_train.txt file

y_train - Read y_train.txt file

subject_train - Read subject_train.txt file

x_test - Read X_test.txt file

y_test - Read y_test.txt file

subject_test - Read subject_test.txt file

features - Read features.txt file

activity_labels - Read activity_labels.txt file

all_train - Merged columns from train related files

all_test - Merged columns from test related files

train_test - Merged train and test columns and records

mean_and_std - Mean and Std columns

with_mean_std - mean and Std columns from train_test file

with_activity_labels - Merged with activity_labels

tidy_set - mean by subjectId and activityId columns

final_tidy_set - final file ordered by subjectId and activityId
