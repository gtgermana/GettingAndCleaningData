# “Getting and Cleaning Data” Week 4 Project

> This README.md file describes the generation of a tidy dataset from a set of input files.

>T he Human Activity Recognition Using Smartphones Dataset, of which eight files were of interest to this project, was first downloaded and stored on my computer. The files of interest are:

* X_test.txt - test dataset observations
* y_test.txt - test dataset activity codes
* subject_test.txt - test dataset subject identifiers
* X_train.txt - training dataset observations
* y_train.txt - training dataset activity codes
* subject_train.txt - training dataset subject identifiers
* activity_labels.txt - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, LAYING, SITTING, STANDING
* features.txt - feature names (i.e., variables)

> A run_analysis script was created to transform the raw data into a tidy dataset. The general outline of the script processing steps are as follows:

> Step 0: Read in the data files. Create separate test and training datasets by “column binding” the corresponding activity codes, subject IDs, and observations

> Step 1: Merge the training and test datasets to create one dataset. This is done by “row binding” the test and training datasets.

> Step 2: Extract the mean and standard deviation variables for each observation. That is, keep only the variables (i.e, columns) of interest - those that have mean or std in their names. Seventy-nine variables of interest are found using grep. The remaining variables (482) are discarded. This results in a data.frame with 81 variables, the first two being the activity code and the subject ID.

> Step 3: Use descriptive activity names to name the activities in the dataset. The activity codes are replaced with the activity names: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS AND WALKING_UPSTAIRS.

> Step 4: Appropriately label the dataset with descriptive variable names. This results in more user friendly names. See the CodeBook.md file for details on the variable naming convention.

> Step 5: Create a second, independent tidy dataset with the average of each variable for each activity and each subject. The primariy order is by activity, the secondary order by subject ID. The activities are sorted in alphabetical order, LAYING first and WALKING_UPSTAIRS last. For each activity, there are thirty subjects. Thus the complete tidy dataset is 180 rows (obserations) (30 x 6) by 81 columns (variables). 

> Comments within the script describe the processing in more detail.

> Once the script is executed a tidyDataset data.frame is created. This was then written to a csv file using

>> write.table(tidyDataset,"tidyDataset.txt", quote = FALSE, sep = ",", row.names = FALSE)

> It can be read using

>> tidyDataset <- read.table("tidyDataset.txt", header = TRUE, sep = ",")

> So why is this a tidy dataset? Each variable forms one column, each observation forms one row, and each type of observational unit forms a table. (See Hadley Wickham, “Tidy Data”, for a discussion on tidy data. These definitions are found in Section 2.3.)

> Note that another useful reference for this project is David Hood’s “Getting and Cleaning the Assignment” blog from September 2015.

> Further details can be found by reading the documentation provided with the original data.









