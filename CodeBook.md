## Code Book for run_analysis()

The run_alanysis() function will create 2 data set files:
* tidyOutput.txt
* averageActivitySubject.txt

### tidyOutput.txt
This data set contains 68 columns:
* The first column is the Subject (represented by Integer from 1-30, given by the original data set)
* The second column is the descriptive labels (transformed from "activity_labels.txt" file given by the original data set)
* Column 3-68 are the mean() and std() variables given by original data set (i.e. X_train.txt and X_test.txt)
* The selection criterion for these variables are :
** if the original column name (as specified in "features.txt") contain either "mean()" or "std()", then the variable will be selected.
** The label of Column 3-68 are based on the original column name, with the following modification:
*** Rename "mean()" to "Mean"
*** Rename "std()" to "Std"
*** Remove "-"

### averageActivitySubject.txt
This data set is derived from "tidyOutput.txt" file, with the following changes:
* The columns are almost the same as tidyOutput.txt, with the 1st and 2nd column being swapped.
* The rows are collapsed and aggregated to show the average of each variables in Column 3-68, grouped by 1st column ("Activity") and 2nd column ("Subject").
