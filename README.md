DataCleaning
============

Course Project

Steps to run the run_analysis.R script.

- Download the R script to the folder of your choice. Set the R working directory
to the same folder.

- UCI HAR Dataset is directly being downloaded in the R script or you can download it
from here - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- Run the R script "run_analysis.R". It will take in the dataset and do the following - 
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each     
    measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. Creates a second, independent tidy data set with the average of each variable for         
    each activity and each subject. 

- The resulting tidy data set is written in a file called "new_dataset_with_average_over_cols.txt". t is a 180x68 data frame.


