

## Getting and Cleaning Data Project  

**Purpose**  
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. 

**Data Source**  
The data is collected from the accelerometers of Samsung Galaxy S smartphone.

**Description**  
Here is the detailed description of R script- run_analysis.R

**1.Merges the training and the test sets to create one data set.**
After setting the source directory for the files, read into tables the data located in  
1. features.txt  
2. activity_labels.txt  
3. subject_train.txt  
4. x_train.txt  
5. y_train.txt  
6. subject_test.txt  
7. x_test.txt  
8. y_test.txt  
Assign column names and merge to create one data set.


**2.Extracts only the measurements on the mean and standard deviation for each measurement.**


```r
mean_and_std_deviation = function(df) {
   .....    
}
```


**3.Uses descriptive activity names to name the activities in the data set**  

**4.Appropriately labels the data set with descriptive variable names.**  
 

**5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

Created tidy.txt and UCL_HAR_tidy.csv with 

**1.Identifiers.**  
1. Subject  
2. Activity  

**2.Mearurements.**  
1. tBodyAccMeanX  
2. tBodyAccMeanY  
3. tBodyAccMeanZ  
4. tBodyAccStdX ...

**3.Acitivty labels.**  
1. WALKING  
2. WALKING_UPSTAIRS  
3. WALKING_DOWNSTAIRS  
4. SITTING  
5. STANDING  
6. LAYING  


```r
clean_data = function() {
       ...
}
```

