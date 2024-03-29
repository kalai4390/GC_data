# This codebook details the operations performed by the run_analysis.R script
The script performs downlaodaing the data, cleaning and then the 5 steps described in the course project’s definition.

## Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

## Assign each data to variables
1. features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals
2. activities <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
3. subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
4. x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
5. y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
6. subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
7. x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
8. y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

## Merges the training and the test sets to create one data set
1. X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
2. Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
3. Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
4. Merge_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

## Extract only the measurements on the mean and standard deviation for each measurement
1. Final_Data (10299 rows, 88 columns) is created by subsetting Merge_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

## Use descriptive activity names to name the activities in the data set
1. Entire numbers in code column of the Final_Data isreplaced with corresponding activity taken from second column of the activities variable

## Appropriately labels the data set with descriptive variable names
1. code column in Final_Data renamed into activities
2. Acc in column’s name replaced by Accelerometer
3. Gyro in column’s name replaced by Gyroscope
4. BodyBody in column’s name replaced by Body
5. Mag in column’s name replaced by Magnitude
6. starting with character f in column’s name replaced by Frequency
7. starting with character t in column’s name replaced by Time

## From the data set above, creates a second, independent tidy data set with the average of each variable for each activity and each subject
1. Second_dataset (180 rows, 88 columns) is created by sumarizing Final_Data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
2. Export Second_dataset into Second_dataset.txt file.
