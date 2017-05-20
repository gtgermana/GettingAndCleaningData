# This script implements the "Getting and Cleaning Data" course Week 4 project.

library(dplyr)

# Read the test dataset observations
testObs <- read.table("./test/X_test.txt")

# Read the training dataset observations
trainingObs <-read.table("./train/X_train.txt")

# Read the test dataset activity codes
testCodes <- read.table("./test/y_test.txt")
testCodes <- rename(testCodes, activity = V1)

# Read the training dataset activity codes
trainingCodes <-read.table("./train/y_train.txt")
trainingCodes <- rename(trainingCodes, activity = V1)

# Read the test subject identifiers
testSubjects <- read.table("./test/subject_test.txt")
testSubjects <- rename(testSubjects, subjectID = V1)

# Read the training subject identifiers
trainingSubjects <- read.table("./train/subject_train.txt")
trainingSubjects <- rename(trainingSubjects, subjectID = V1)

# Read the activity labels (e.g., WALKING, WALKING_UPSTAIRS, etc.)
activityLabels <- read.table("activity_labels.txt")
activityLabels <- as.character(activityLabels$V2)

# Create the complete test dataset
testDataset <- cbind(testCodes, testSubjects, testObs)

# Create the complete training dataset
trainingDataset <- cbind(trainingCodes, trainingSubjects, trainingObs)

# STEP 1: Merge the training and test datasets to create one dataset
fullDataset <- rbind(trainingDataset, testDataset)

# STEP 2: Extract only the mean and standard deviation variables for each observation
# That is, keep only the variables (i.e, columns) of interest - those that have mean or std in their names
# Read the feature names
featureNames <- read.table("features.txt")
#Get the indices for the features of interest
varIndices <- grep("mean|std", featureNames$V2)
meanStdDataset <- select(fullDataset, c(1:2, (varIndices + 2)))

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
numSubjects = length(unique(meanStdDataset$subjectID))
numActivityLabels = length(activityLabels)
numRows = numSubjects * numActivityLabels
numVars = length(names(meanStdDataset)) - 2
tidyDataset <- data.frame(activity = rep(1, numRows), subjectID = rep(1, numRows),
                   matrix(rep(0, numVars * numRows), numRows))
names(tidyDataset) <- names(meanStdDataset)

m = 0
for (i in 1:numActivityLabels) {
    for (j in 1:numSubjects) {
        m = m + 1
        a1 = filter(meanStdDataset, (activity == activityLabels[i]) & (subjectID == j))
        tidyDataset[m, 1] = activityLabels[i]
        tidyDataset[m, 2] = j
        tidyDataset[m, 3:ncol(a1)] <- colMeans(a1[,3:ncol(a1)])
    }
}    
rm(fullDataset, meanStdDataset, testDataset,trainingDataset, testObs, trainingObs)
rm(testCodes, testSubjects, trainingCodes, trainingSubjects, a1)
#rm(activityLabels, featureNames, varIndices)

tidyDataset <- arrange(tidyDataset, activity, subjectID)
