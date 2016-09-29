# Getting and Cleaning Data Peer Project

This repo contains the `run_analysis.R` script that transforms and cleans the wearables data from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). `run_analysis.R` in the root of the repo will load the training and testing data set from the `UCI HAR Dataset` directory and process it. `run_analysis.R` does the following steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.