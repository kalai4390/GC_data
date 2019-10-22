#downloading the file
dataset <- "Coursera_Data.zip"

# Checking if archieve already exists.
if (!file.exists(dataset)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, dataset)
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(dataset) 
}

# Assigning all data frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


# Merge the training and the test sets to create one data set

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merge_Data <- cbind(Subject, Y, X)


# Extract only the measurements on the mean and standard deviation for each measurement.

Final_Data <- Merge_Data %>% select(subject, code, contains("mean"), contains("std"))
#Uses descriptive activity names to name the activities in the data set.

Final_Data$code <- activities[Final_Data$code, 2]

#Appropriately labels the data set with descriptive variable names.

names(Final_Data)[2] = "activity"
names(Final_Data)<-gsub("Acc", "Accelerometer", names(Final_Data))
names(Final_Data)<-gsub("Gyro", "Gyroscope", names(Final_Data))
names(Final_Data)<-gsub("BodyBody", "Body", names(Final_Data))
names(Final_Data)<-gsub("Mag", "Magnitude", names(Final_Data))
names(Final_Data)<-gsub("^t", "Time", names(Final_Data))
names(Final_Data)<-gsub("^f", "Frequency", names(Final_Data))
names(Final_Data)<-gsub("tBody", "TimeBody", names(Final_Data))
names(Final_Data)<-gsub("-mean()", "Mean", names(Final_Data), ignore.case = TRUE)
names(Final_Data)<-gsub("-std()", "STD", names(Final_Data), ignore.case = TRUE)
names(Final_Data)<-gsub("-freq()", "Frequency", names(Final_Data), ignore.case = TRUE)
names(Final_Data)<-gsub("angle", "Angle", names(Final_Data))
names(Final_Data)<-gsub("gravity", "Gravity", names(Final_Data))

# From the Final_Data, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Second_dataset <- Final_Data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Second_dataset, "Second_dataset.txt", row.name=FALSE)