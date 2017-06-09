# This R Script collects, works with, and cleans a data set.
# Data (wearable computing ) is collected from the 
# accelerometers of Samsung Galaxy S smartphone.
# The full description of the data set is available at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

library(plyr)

# Dowloading data
download_data = function() {
        #Creating data directory 
        if (!file.exists("data")) {
                dir.create("data")
        }
        if (!file.exists("data/UCI HAR Dataset")) {
                # download the data
                fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                zipfile="data/UCI_HAR_data.zip"
                download.file(fileURL, destfile=zipfile, method="curl")
                unzip(zipfile, exdir="data")
        }
}

# Function Merges the train and the test sets to create one data set.
merge_datasets = function() {
        # Read data
        train_x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
        train_y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
        train_subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
        test_x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
        test_y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
        test_subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
        
        # Merging train sets 
        merging_x <- rbind(train_x, test_x)
        merging_y <- rbind(train_y, test_y)
        merging_subject <- rbind(train_subject, test_subject)
        
        # Merging train and test datasets to create one dataset 
        list(x=merging_x, y=merging_y, subject=merging_subject)
}

# Function Extracts only the measurements on the mean and 
# standard deviation for each measurement of data frame.
mean_and_std_deviation = function(df) {
        
        # Read the feature list file
        features <- read.table("data/UCI HAR Dataset/features.txt")
        # Determine the coumns of mean & std Extract them from the data
        mean_col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
        std_col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
        new_df <- df[, (mean_col | std_col)]
        
        # Ensure to keep subjectID and activity columns
        colnames(new_df) <- features[(mean_col | std_col), 2]
        new_df
}

# Function Uses descriptive activity names to
# name the activities in the data frame
naming_activities = function(df) {
        colnames(df) <- "activity"
        df$activity[df$activity == 1] = "WALKING"
        df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
        df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
        df$activity[df$activity == 4] = "SITTING"
        df$activity[df$activity == 5] = "STANDING"
        df$activity[df$activity == 6] = "LAYING"
        df
}



clean_data = function() {
        
        # Download data
        message("Downloading Data")
        download_data()
        
        # Merging training and test datasets
        message("Merging and Creating One Data set")
        merged_data <- merge_datasets()
        
        # Extract the mean and standard deviation of each
        # measurement
        message("Extracts only the measurements on the mean and
                standard deviation for each measurement")
        mean_std_df_x <- mean_and_std_deviation(merged_data$x)
        
        # Name activities
        message("Using descriptive activity names to name 
                the activities in the data set")
        naming_activities_df_y <- naming_activities(merged_data$y)
        
        # Use descriptive column name for subjects
        colnames(merged_data$subject) <- c("subject")
        
        # Combine mean-std values , activities 
        # and subjects into one data frame.
        combined_dataset <- cbind(mean_std_df_x, 
                                  naming_activities_df_y,
                                  merged_data$subject)


        # Create tidy dataset
        tidy_dataset <- ddply(combined_dataset, 
                              .(subject, activity), 
                              function(x) colMeans(x[,1:60]))
        tidy_dataset
        
        write.table(tidy_dataset, "tidy.txt", row.names = FALSE, quote = FALSE)
        
        # Write tidy dataset as csv
        #message("Writing tidy data to UCI_HAR_tidy.csv")
        write.csv(tidy_dataset, "UCI_HAR_tidy.csv", row.names=FALSE)
}

