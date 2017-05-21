# This script implements the "Getting and Cleaning Data" Course Week 4 project. The STEPs below
# correspond to the Steps in the course project description.

library(dplyr)

# Read the test dataset observations
testObs <- read.table("X_test.txt")

# Read the training dataset observations
trainingObs <-read.table("X_train.txt")

# Read the test dataset activity codes
testCodes <- read.table("y_test.txt")
testCodes <- rename(testCodes, activity = V1)

# Read the training dataset activity codes
trainingCodes <-read.table("y_train.txt")
trainingCodes <- rename(trainingCodes, activity = V1)

# Read the test subject identifiers
testSubjects <- read.table("subject_test.txt")
testSubjects <- rename(testSubjects, subjectID = V1)

# Read the training subject identifiers
trainingSubjects <- read.table("subject_train.txt")
trainingSubjects <- rename(trainingSubjects, subjectID = V1)

# Read the activity labels (e.g., WALKING, WALKING_UPSTAIRS, etc.)
activityLabels <- read.table("activity_labels.txt")
activityLabels <- as.character(activityLabels$V2)

# Create the complete test dataset
testDataset <- cbind(testCodes, testSubjects, testObs)
rm(testCodes, testSubjects, testObs)

# Create the complete training dataset
trainingDataset <- cbind(trainingCodes, trainingSubjects, trainingObs)
rm(trainingCodes, trainingSubjects, trainingObs)

# STEP 1: Merge the training and test datasets to create one dataset
fullDataset <- rbind(trainingDataset, testDataset)
rm(trainingDataset, testDataset)

# STEP 2: Extract only the mean and standard deviation variables for each observation
# That is, keep only the variables (i.e, columns) of interest - those that have mean or std in their names
# Read the feature names
featureNames <- read.table("features.txt")
#Get the indices for the features of interest
varIndices <- grep("mean|std", featureNames$V2)
meanStdDataset <- select(fullDataset, c(1:2, (varIndices + 2)))
rm(fullDataset)

# STEP 3: Use descriptive activity names to name the activities in the dataset
meanStdDataset <- mutate(meanStdDataset, activity = activityLabels[activity])

# STEP 4: Appropriately label the dataset with descriptive variable names
# Select the feature names of interest - those with mean() or std() in their names
featureNames <- as.character(featureNames[varIndices,2])
# Rename feature names - see Codebook for the naming method
featureNames <- gsub("meanFreq()", "MeanFreq", featureNames, fixed = TRUE)
featureNames <- gsub("Acc", "Accel", featureNames, fixed = TRUE)
featureNames <- gsub("-mean()", "Mean", featureNames, fixed = TRUE)
featureNames <- gsub("-std()", "Std", featureNames, fixed = TRUE)
featureNames <- gsub("-", "", featureNames, fixed = TRUE)
featureNames <- sub("^t", "time", featureNames)
featureNames <- sub("^f", "freq", featureNames)
names(meanStdDataset)[3:(length(featureNames) + 2)] = featureNames

# STEP 5: From the dataset in STEP 4, create a second, independent tidy dataset with the average of each 
# variable for each activity and each subject
tidyDataset <- aggregate(meanStdDataset[, 3:ncol(meanStdDataset)], list(activity = meanStdDataset$activity,
                         subjectID = meanStdDataset$subjectID), mean)
rm(meanStdDataset)
rm(activityLabels, featureNames, varIndices)

# Order the dataset by activity, then for each activity, by subjectID
tidyDataset <- arrange(tidyDataset, activity, subjectID)
