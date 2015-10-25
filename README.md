# DataCleaningProject

Requirements:
 Create one R script called run_analysis.R that does the following. 

   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names. 
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Resources:
1. Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R does the following:
1. Reads the data from the files in the current working directory
2. Extracts the required variables from the list of 561 variables using grep(). [features_needed]
3. Activity labels are read from the corresponding text file into activity_labels dataframe
4. Extract the variables/columns needed from train datasets
a. Using features_needed, the Xdata for the needed columns are extracted from "train_X.txt" file into train_dataX
b. Y data is read from "train_y.txt" into train_dataY dataframe
c. Subject data is read from the "subject_train.txt" file into subject_train dataframe
d. Combine train_subject,train_dataY,train_dataX are combined column wise using cbind() to get TrainData
5. Test dataset manipulation
a. Using features_needed, the Xdata for the needed columns are extracted from "test_X.txt" file into test_dataX
b. Y data is read from "test_y.txt" into test_dataY dataframe
c. Subject data is read from the "subject_test.txt" file into subject_test dataframe
d. Combine test_subject,test_dataY,test_dataX are combined column wise using cbind() to get TestData
6. Combine TrainData and TestData using rbind() to get the FullData set for Step 4
7. Step 5 - tidy dataset generation
a. Convert SubjectId & ActivityName to factors to facilitate easy reshaping of data
b. Use melt() to reshape the FullData based on SubjectId & ActivityName as id
c. Use dcast() on data resulted from the melt() to calculate the means as required for step 5
8. Dataframe resulting from dcast() is written into "fulldata.txt" file.
9. 
