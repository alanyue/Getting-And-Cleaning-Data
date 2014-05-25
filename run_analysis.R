# Getting & Cleaning Data Course Project

## run_analysis function performs the following actions:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable
##    for each activity and each subject. 

library(reshape2)

run_analysis <- function(dataDir = "./UCI HAR Dataset/") {

  ## 'dataDir' is the directory to hold the original raw data set

  ## set the source data files
  testDataFile <- sprintf("%s%s", dataDir, "test/X_test.txt")
  if( !file.exists(testDataFile)) stop ("Test Data file not exist")
  testSubFile <- sprintf("%s%s", dataDir, "test/subject_test.txt")
  if( !file.exists(testSubFile)) stop ("Test Subject file not exist")
  testLabelFile <- sprintf("%s%s", dataDir, "test/y_test.txt")
  if( !file.exists(testLabelFile)) stop ("Test Label file not exist")
  
  trainDataFile <- sprintf("%s%s", dataDir, "train/X_train.txt")
  if( !file.exists(trainDataFile)) stop ("Train Data file not exist")
  trainSubFile <- sprintf("%s%s", dataDir, "train/subject_train.txt")
  if( !file.exists(trainSubFile)) stop ("Train Subject file not exist")
  trainLabelFile <- sprintf("%s%s", dataDir, "train/y_train.txt")
  if( !file.exists(trainLabelFile)) stop ("Train Label file not exist")
  
  ## other static data files
  activityLabelsFile <- sprintf("%s%s", dataDir, "activity_labels.txt")
  if( !file.exists(activityLabelsFile)) stop ("Activity Labels file not exist")
  featuresFile <- sprintf("%s%s", dataDir, "features.txt")
  if( !file.exists(featuresFile)) stop ("features file not exist")
  
  ## extract the mean() and std() column indexes
  featuresDF <- read.table(featuresFile)
  meanCols <- grep( "mean()", featuresDF[[2]], fixed=TRUE)
  stdCols <- grep( "std()", featuresDF[[2]], fixed=TRUE)
  meanStdColIndex <- sort(c(meanCols,stdCols))
  meanStdColNames <- featuresDF[meanStdColIndex,2]
  
  ## clean up the column names, i.e. changing mean() to Mean, std(), to Std, and removing "-"
  meanStdColNames <- gsub("mean\\(\\)", "Mean", meanStdColNames)
  meanStdColNames <- gsub("std\\(\\)", "Std", meanStdColNames)
  meanStdColNames <- gsub("-", "", meanStdColNames)
  
  ## load the Activity Labels
  activityMap <- read.table(activityLabelsFile)
  
  ## test and train data tidy process
  testData <- tidyData(testDataFile, testSubFile, testLabelFile, meanStdColIndex, meanStdColNames, activityMap )
  trainData <- tidyData(trainDataFile, trainSubFile, trainLabelFile, meanStdColIndex, meanStdColNames, activityMap )
  
  # combine both to become the output data
  outputData <- rbind( testData, trainData)
  
  # write the tidy data to an output file
  write.table(outputData, "tidyOutput.txt", row.names = FALSE)
  
  # Creates a second tidy data set with the average of each variable for each activity and each subject
  moltenOutput = melt(outputData, id = c("Activity", "Subject"), na.rm = TRUE)
  avgPerActivitySubject <- dcast(moltenOutput, formula = Activity + Subject ~ variable, mean)
  write.table(avgPerActivitySubject, "averageActivitySubject.txt", row.names = FALSE)
}


tidyData <- function(rawFile, subjectFile, labelFile, subsetColIndex, subsetColNames, activityMap) {
  
  # retreive the subject and assign to 1st column of the output
  outputDF <- read.table(subjectFile)
  names(outputDF) <- "Subject"
  
  # retreive the activity labels and assign to 2nd column of the output
  activityDF <- read.table(labelFile)
  activityDF$Label = activityMap[activityDF[[1]],2]
  outputDF <- cbind(outputDF, Activity = activityDF$Label)

  # retreive the rawFile
  rawDF <- read.table(rawFile)
  
  # extract selected columns (i.e. mean and std variables) from the raw data
  selectedDF <- rawDF[,subsetColIndex]
  
  # assign the descriptive column names
  names(selectedDF) <- subsetColNames
  
  # bind the selected dataframe to output
  outputDF <- cbind(outputDF, selectedDF)
  
  outputDF
}
