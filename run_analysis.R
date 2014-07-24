## created by pmccullo06 
## last updated 7-23-2014
## coursera class "getting and cleaning data" final project

## you need plyr package

# url for data as given in class

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


#1. download data (may not need in final project script, will comment out if so)

#live newfile = "RecognitionData.zip"

#live download.file(url,destfile = "./RecognitionData.zip", method = "curl")
#live datedownload <- date()

#2 extract data from zipped format (commentted out, as this is no longer needed)

#live unzip(newfile)

#3 Begin processing data

# get and merge test and training datasets
path_test <- "./UCI HAR Dataset/test/X_test.txt"
path_train <- "./UCI HAR Dataset/train/X_train.txt"

test_data <- read.table(path_test)
train_data <- read.table(path_train)
all_data <- rbind(test_data,train_data)

# derived columns to grab mean & std for 17 measurements manually :(
vectorcolumns <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,
125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,
266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,
503,504,516,517,529,530,542,543)

# master data set created for means & STDs:
mean_std_data_only <- all_data[,vectorcolumns]



#create master activity label set
path_test <- "./UCI HAR Dataset/test/Y_test.txt"
path_train <- "./UCI HAR Dataset/train/Y_train.txt"

test_labels <- read.table(path_test)
train_labels <- read.table(path_train)
all_data_labels <- rbind(test_labels,train_labels)

#lookup activity to number cross reference
path_activity_labels <- "./UCI HAR Dataset/activity_labels.txt"
activitylookup <- read.table(path_activity_labels)

#change activity numbers into words
activity_levels <- activitylookup[,1]
activity_labels <- as.character(activitylookup[,2])
all_data_labels$V1 <- ordered(all_data_labels$V1, levels = activity_levels, labels = activity_labels)


# add labels to master data set

mean_std_data_only <- cbind(all_data_labels,mean_std_data_only)

#column labels

# create column labels
all_vectorlabels <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
measure_vectorlabels <- all_vectorlabels[vectorcolumns,2]
use_vectorlabels <- c("Activity_Name",measure_vectorlabels)

names(mean_std_data_only) <- c(use_vectorlabels)


########## completed steps 1-4

### creating final tidy data set with columns Subject, Activity, Measurements

# get and merge subject into mead_std_data_only)

path_test <- "./UCI HAR Dataset/test/subject_test.txt"
path_train <- "./UCI HAR Dataset/train/subject_train.txt"

test_subject <- read.table(path_test)
train_subject <- read.table(path_train)
all_data <- rbind(test_subject,train_subject)

tidydata1 <- cbind(all_data,mean_std_data_only)
colnames(tidydata1)[1] <- "Subject"

library(plyr)
# add unqiue combination column

tidydata2 <- mutate(tidydata1,concated_column = paste(tidydata1$Subject,tidydata1$Activity,sep=" "))

tidydata3 <- as.data.table(tidydata2)
tidydata4 <- tidydata3[, lapply(.SD, mean), by = "concated_column"]
tidydata5 <- as.data.frame(tidydata4)
tidydata6 <- tidydata5[,2:69]
# change activities back to activity name
#change activity numbers into words
activity_levels <- activitylookup[,1]
activity_labels <- as.character(activitylookup[,2])

tidydata6$Activity_Name <- ordered(tidydata6$Activity_Name, levels = activity_levels, labels = activity_labels)
write.table(tidydata6,"pmccullo_tidydata.txt")
