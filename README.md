pmccullo Cousera Getting & Cleaning Data - Final Project
============================
The following instructions were provided by the professors:
Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


1. You should create one R script called run_analysis.R that does the following. 
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

-------

The following steps that I took are either outside of the code or are in the begining of my run_analysis.R code, but are commented out

1. Download data to working directory using download.file()
2. Unzip using unzip()
3. Thoroughly read through README.txt to understand data structure (not in code)
4. The main Test & Training data have observations with 561 measurements, column headers for hte measurements can be found in the features.txt file (good background in the features_Info.txt as well)






