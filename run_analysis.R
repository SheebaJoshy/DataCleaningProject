##Data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##downloaded and unzipped in the working directory

##set the path to working directory
setwd("C:/Users/sbiju_000/R Programming/UCI HAR Dataset/")

##Reading features and activity labels
features_data<- read.table("./features.txt")
#features_data[, 2] <- as.character(features_data[,2])
activity_labels<-read.table("./activity_labels.txt")
#activity_labels[,2]<-as.character(activity_labels[,2])

##Find required features
features_needed<-grep(".*mean.*|.*std.*", features_data[,2])
features_needed.names<-features_data[features_needed,2]
features_needed.names = gsub('-mean', 'Mean', features_needed.names)
features_needed.names = gsub('-std', 'StdDev', features_needed.names)
features_needed.names <- gsub('[-()]', '', features_needed.names)

##Reading train data set variables
train_dataX<- read.table("./train/X_train.txt")[features_needed]
train_dataY <- read.table("./train/Y_train.txt") 
train_subject<-read.table("./train/subject_train.txt")

TrainData<-cbind(train_subject,train_dataY, train_dataX)  ##Forming the traindata 

##Reading test data set variables
test_dataX<- read.table("./test/X_test.txt")[features_needed]
test_dataY <- read.table("./test/Y_test.txt") 
test_subject<-read.table("./test/subject_test.txt")

TestData<- cbind(test_subject,test_dataY, test_dataX) ##Forming testdata

##All dataset - Step 4: Combining the train data & test data row wise

FullData<-rbind(TrainData,TestData)

##column names given for the FullData set

colnames(FullData)<- c("SubjectId", "ActivityName", features_needed.names)

##Changing subject & activity to factors
FullData$SubjectId <- as.factor(FullData$SubjectId)
FullData$ActivityName<- factor(FullData$ActivityName, levels= activity_labels[,1], 
                               labels = activity_labels[,2])

##Using melt() to reshape the dataset based on SubjectId & ActivityName
FullData.FDMelt<- melt(FullData, id = c("SubjectId" , "ActivityName"))

##Dataset is reshaped again using dcast() and mean is applied
FullData.mean <-dcast(FullData.FDMelt, SubjectId + ActivityName ~ variable, mean)

##Resultant dataset is written into the fulldata.txt file
write.table(FullData.mean, "fulldata.txt", row.names=FALSE, quote=FALSE)

##For double verification I have written the file as a csv also
write.table(FullData.mean,"./fulldata.csv")
