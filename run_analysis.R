#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#setwd("C:/Users/<user name>/Documents/Data Science/Course 3")

#Download and unzip data set
if (!file.exists("./data")) {
    dir.create("./data")
}
fileUrl <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", mode = "wb")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# train tables
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <-
    read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# test tables
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <-
    read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# features table
features <- read.table('./data/UCI HAR Dataset/features.txt')

# activity labels
activity_labels <= read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Add columns
colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity_labels) <- c('activityId', 'activityType')

# Merge all data

all_train <- cbind(y_train, subject_train, x_train)
all_test <- cbind(y_test, subject_test, x_test)
train_test <- rbind(all_train, all_test)

# Check merged data file
#write.table(train_test, "./data/train_test.txt", row.name=FALSE)

# Extract mean and standard deviation
colNames <- colnames(train_test)

mean_and_std <- (
    grepl("activityId" , colNames) |
        grepl("subjectId" , colNames) |
        grepl("mean.." , colNames) |
        grepl("std.." , colNames)
)

with_mean_std <- train_test[, mean_and_std == TRUE]

# Data set with descriptive variable names
setWithActivityNames <- merge(with_mean_std,
                              activity_labels,
                              by = 'activityId',
                              all.x = TRUE)
# Second independent tidy data set with the average of each variable for each activity and each subject

tidy_set <-
    aggregate(. ~ subjectId + activityId, setWithActivityNames, mean)
#write.table(tidy_set, "./data/tidy_set.txt", row.name=FALSE)

final_tidy_set <-
    tidy_set[order(tidy_set$subjectId, tidy_set$activityId), ]
write.table(final_tidy_set, "./data/tidy_set.txt", row.name = FALSE)