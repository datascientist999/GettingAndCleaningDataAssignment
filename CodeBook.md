## R script

File "run_analysis.R" 
Steps are mentioned below

# 1. Merges the training and the test sets to create one data set.
	# Download and unzip data set
	# Read train tables
	# Read test tables
	# Read features table
	# Read activity labels
	# Add columns
	# Merge all data
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	# Extract mean and standard deviation

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
	# Data set with descriptive variable names

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	# Second independent tidy data set with the average of each variable for each activity and each subject

fileUrl - URL for data set file download
x_train - Read X_train.txt file
y_train - Read y_train.txt file
subject_train - Read subject_train.txt file
x_test - Read X_test.txt file
y_test - Read y_test.txt file
subject_test - Read subject_test.txt file
features - Read features.txt file
activity_labels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
      
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
      
colnames(activity_labels) <- c('activityId','activityType')


all_train <- cbind(y_train, subject_train, x_train)
all_test <- cbind(y_test, subject_test, x_test)
train_test <- rbind(all_train, all_test)

colNames <- colnames(train_test)

mean_and_std <- (grepl("activityId" , colNames) | 
                 grepl("subjectId" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames))

with_mean_std <- train_test[ , mean_and_std == TRUE]

setWithActivityNames <- merge(with_mean_std, activity_labels,
                              by='activityId',
                              all.x=TRUE)

tidy_set <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
#write.table(tidy_set, "./data/tidy_set.txt", row.name=FALSE)

final_tidy_set <- tidy_set[order(tidy_set$subjectId, tidy_set$activityId),]
write.table(final_tidy_set, "./data/tidy_set.txt", row.name=FALSE)


## Variables

x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in