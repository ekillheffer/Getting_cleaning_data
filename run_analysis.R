# Remove everything from the workspace
rm(list = ls())

# Set working directory
setwd("C:/Users/erin/Desktop/Coursera/GettingData/UCI HAR Dataset")

library(dplyr)
library(tidyr)

# Read in train files
features <- read.table('./features.txt',header=FALSE)  #imports features.txt
activity <- read.table('./activity_labels.txt',header=FALSE)   #imports activity_labels.txt
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)   #imports subject_train.txt
train_set <- read.table('./train/x_train.txt',header=FALSE)   #imports x_train.txt
train_label <- read.table('./train/y_train.txt',header=FALSE)   #imports y_train.txt

# Read in the test files
subjectTest <- read.table('./test/subject_test.txt',header=FALSE)  #imports subject_test.txt
test_set <- read.table('./test/x_test.txt',header=FALSE)  #imports x_test.txt
test_label <- read.table('./test/y_test.txt',header=FALSE)  #imports y_test.txt


# label columns
feature_labels <- as.character(features$V2)
feature_labels <- tolower(feature_labels)
feature_labels <- gsub('[-()]', '', feature_labels)

# Mean and Standard Dev colums
mean_std_col <- grep(".*mean.*|.*std.*", feature_labels)
feature_names <- feature_labels[mean_std_col]

# Merge train and test datasets
sets <- rbind(train_set, test_set)
labels <- rbind(train_label, test_label)
subjects <-rbind(subjectTrain, subjectTest) 

## Keep mean and std cols
final_set <- sets[mean_std_col]

## merge actiity names
names(activity) <- c("activity", "act_label")
names(labels) <- "activity"
activity_key <- left_join(labels, activity, by= "activity")
labeled_activity <- select(activity_key, act_label)

## combine data and label
all_data <- cbind(subjects, labeled_activity, final_set)
names(all_data) <- c("subject", "activity", feature_names)

## create second tidy data set
grouped_data <- group_by(all_data, subject, activity)
tidy <- summarize_each(grouped_data, funs(mean))
write.table(tidy, "tidy.txt", row.names = FALSE, sep = "\t")
