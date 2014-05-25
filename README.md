## Getting-And-Cleaning-Data : Project Assignment

### Goal:
* This project is to demonstrate how we utilize R programming to collect, clean, and transform data set.
* The original data set is based on a project related to the human activity recognition using smartphone.
* Detail of that project can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* Raw data set can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Tasks:
* 1. Merges the training and the test sets to create one data set.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
* 3. Uses descriptive activity names to name the activities in the data set
* 4. Appropriately labels the data set with descriptive activity names. 
* 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Implementation:
The entire process is automated by the R script : "run_analysis.R" 
This R script assumes that the original data set is already downloaded and unzipped in a local directory.

### Steps to run the R script:
* 1. source the R script into your R environment, i.e., in the R command line:
	source("run_analysis.R")
* 2. run the function "run_analysis", i.e., in the R command line:
	run_analysis()
* 3. the function will assume the original data set's local directory to be "./UCI HAR Dataset/". You could override by specifying in the parameter:
	e.g. run_analysis("/c/user/xxx/UCI HAR Dataset/")
	
### Output:
The R script will create 2 data set files:
* 1. Filename "tidyOutput.txt", saved in the current directory. This file covers Tasks 1-4 mentioned above.
* 2. Filename "averageActivitySubject.txt", saved in the current directory. This file covers Task 5 mentioned above.

For details of the variables covered in these 2 output files, please refer to "CodeBook.md"



