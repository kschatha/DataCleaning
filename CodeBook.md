The given R script "run_analysis.R" performs the following steps to clean
and process the given data.

- 1. Merges the training and test sets to create one data set, namely

In this step, the training and testing data is combined to one dataset.
The files combined are - UCI HAR Dataset/train/X_train.txt and UCI HAR Dataset/test/X_test.txt. 

This results in a data frame names "setData" of size 10299 x 561

- 2. Extracts only the measurements on the mean and standard deviation for each measurement.

In this step, only the mean and standard deviation measurements are extracted
from the "setData". To do this, first the feature data is read from "UCI HAR Dataset/features.txt" into a data fram called "feautres" of size 561 x 2.

From features, the feature names with words "mean" and "std" are grepped and only those indices/column numbers are subsetted from the "setData" and saved into a new data fram "meanSdData" of size 10299 X 66.

ColNames for meanSdData are also changed to more descriptive feature names in the same step.

- 3. Uses descriptive activity names to name the activities in the data set

In this step, the activity labels data is read from files - "UCI HAR Dataset/train/y_train.txt" and "UCI HAR Dataset/test/y_test.txt" and combined into one
data frame called "labelData" of size 10299 x 1.

Activities names are also read into a data frame called "activities" of size 6 x 2 from "UCI HAR Dataset/activity_labels.txt". 

Using the activity names from "activities", the activity label id is replaced
with the activity name in the labelData and descriptive col name is given.


- 4. Appropriately labels the data set with descriptive variable names.

In this step, the subject data is read from "UCI HAR Dataset/train/subject_train.txt" and "UCI HAR Dataset/test/subject_test.txt" into a data frame called
subjectData of size 10299 x 1.

By this step, all the datasets are properly labeled so they are merged into one
big dataset called "bigData" which is a combination of meanSdData, labelData and subjectData and the size of "bigData" is 10299 x 68.

- 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

In this step, a new data set of size 180 x 68 is created where average of each
variable (68) is recorded for each subject and each activity so 180 rows total.

This data set is then written to a local file named "new_dataset_with_average_over_cols.txt"
