#Read the data into R
dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataFile, "UCI-HAR-dataset.zip", method="curl")
unzip("UCI-HAR-dataset.zip")
unlink("UCI-HAR-dataset.zip")

#1. Merges the training and the test sets to create one data set.

#combine the training & test sets - X_train.txt and X_test.txt
xtrain <- read.table( "UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
setData <- rbind( xtrain, xtest)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("UCI HAR Dataset/features.txt")
indicies <- grep("(mean|std)\\(", features[,2])
#extract the column with above indicies from setData
meanSdData <- setData[,indicies]
#give useful names to the cols of the new dataset
names(meanSdData) <- features[indicies,2]
#remove brackets from names of cols
names( meanSdData) <- gsub("\\(|\\)", "", names( meanSdData))
#convert names to lower case
names( meanSdData) <- tolower( names( meanSdData))


#3.Uses descriptive activity names to name the activities in the data set

#combine the training & test activity labels - y_train.txt and y_test.txt
ytrain <- read.table( "UCI HAR Dataset/train/y_train.txt")
ytest <- read.table( "UCI HAR Dataset/test/y_test.txt")
labelData <- rbind( ytrain, ytest)

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
#clean the activities names and convert to lowercase
activities[,2] <- gsub("_", "", tolower( as.character(activities[,2])))
labelData[,1] <- activities[labelData[,1],2]
names( labelData) <- c("activity")


#4.Appropriately labels the data set with descriptive variable names. 

#combine the subjects training & test files - 
#subject_train.txt and subject_test.txt
subtrain <- read.table( "UCI HAR Dataset/train/subject_train.txt")
subtest <- read.table( "UCI HAR Dataset/test/subject_test.txt")
subjectData <- rbind( subtrain, subtest)
names( subjectData) <- c("subject")

#By this points, all the data sets are properly labeled
#combine into 1 big dataset
bigData <- cbind( meanSdData, labelData, subjectData)


#5.Creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject. 

#find unique subjects
uniqSubjects <- unique( subjectData)[,1]
numUniqSub <- length( uniqSubjects)
#find number of activies
numActivities <- length( activities[,2])
#find number of cols of cleaned data
numCols <- ncol( bigData)
#num of rows for new Data set
numRows <- numUniqSub * numActivities
#create a new data set of the given size
newData <- bigData[1:numRows, ]

row = 1
#for each subject
for( i in 1:numUniqSub)
{
    #for each activity
    for( j in 1:numActivities)
    {
        newData[row,1] <- uniqSubjects[i]
        newData[row,2] <- activities[j,2]
        tmpData <- bigData[bigData$subject == i & bigData$activity == j,]
        newData[row,3:numCols] <- colMeans( tmpData[,3:numCols])
        row = row + 1
    }
}

#writing data to file
write.table( newData, "new_dataset_with_average_over_cols.txt")

