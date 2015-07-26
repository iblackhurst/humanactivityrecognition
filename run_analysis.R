#### Getting and Cleaning Data Course Project
top <- "./UCI HAR Dataset"

## Read in the data
subject_train <- read.table(paste(top, "train", "subject_train.txt", sep = "/"))
X_train <- read.table(paste(top, "train", "X_train.txt", sep = "/"))
y_train <- read.table(paste(top, "train", "y_train.txt", sep = "/"))

subject_test <- read.table(paste(top, "test", "subject_test.txt", sep = "/"))
X_test <- read.table(paste(top, "test", "X_test.txt", sep = "/"))
y_test <- read.table(paste(top, "test", "y_test.txt", sep = "/"))

## Get feature names
X_names <- read.table(paste(top, "features.txt", sep = "/"))

## Combines train and test sets and add feature names
## Adding feature names accomplishes step 4:
## Appropriately label the data set with descriptive variable names
subject <- c(subject_train$V1, subject_test$V1)
X <- rbind(X_train, X_test)
colnames(X) <- X_names$V2
y <- c(y_train$V1, y_test$V1)

## Creates one data set
Data <- cbind(subject, y, X)

## Extract the measurements on the mean and standard deviation for each measurement

## Create an index of all columns with either mean or std in them, and
## subset the data to only include those variables
ind1 <- grep("mean|std", X_names$V2, ignore.case = TRUE) 
ind2 <- ind1 + 2
ind3 <- c(1:2, ind2)

DataMeanStd <- Data[, ind3]

## Use descriptive activity names to name the activities in the data set
DataMeanStd$y <- factor(DataMeanStd$y, labels = c("walking", "walking_upstairs", "walking_downstairs",
                                                  "sitting", "standing", "laying"))

## The data set has already been labeled with descriptive variable names.

## This creates the first tidy data set.
write.table(DataMeanStd, "Activity_measurements.txt", row.name = FALSE)

## From the data set in step 4, creates a second, independent tidy data set with 
## the average of each variable for each activity and each subject.

## split the data into data frames by subject and activity
splitData <- split(DataMeanStd, list(DataMeanStd$subject, DataMeanStd$y))

## create a list for each split containing the means of each variable
groupedmeans <- lapply(splitData, function(x) sapply(x[3:88], mean))

## unlisting them so they are easier to work with
unlistgm <- unlist(groupedmeans)

## adding the appropriate dimensions for how the data was unlisted
dim(unlistgm) <- c(86, 180)

## making the columns the variables
gmmatrix <- t(unlistgm)

## creating a data frame with the measurements
gmdf <- as.data.frame(gmmatrix)
colnames(gmdf) <- colnames(DataMeanStd)[3:88]

## adding two rows specifying the subject and activity
subjectandactivity <- strsplit(names(groupedmeans), "[.]")
subectnum <- sapply(subjectandactivity, function(x) x[1])
activity <- sapply(subjectandactivity, function(x) x[2])
tidydf <- cbind(subectnum, activity, gmdf)

## writing the data frame out
write.table(tidydf, file = "Average_activity_measurements.txt", row.name = FALSE)


