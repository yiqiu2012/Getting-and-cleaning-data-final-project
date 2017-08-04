#Run_analysis 
setwd("~/Desktop/Getting and cleaning data")
#Merge the training and the test sets to create one data set
##Download the file from the internet
if(!file.exists("~/Desktop/Getting and cleaning data/projectData")){dir.create("~/Desktop/Getting and cleaning data/projectData")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="~/Desktop/Getting and cleaning data/projectData/projectData.zip",method="curl")

##Unzip the file
file<-unzip("~/Desktop/Getting and cleaning data/projectData/projectData.zip",exdir="./projectData")

##Read the data into R
train.x<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/train/X_train.txt")
train.y<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/train/y_train.txt")
train.subject<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/train/subject_train.txt")
test.x<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/test/X_test.txt")
test.y<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/test/y_test.txt")
test.subject<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/test/subject_test.txt")

##Merge
training<-cbind(train.subject,train.y,train.x)
test<-cbind(test.subject,test.y,test.x)
fullData<-rbind(training,test)

#Extract only the measurements on the mean and standard deviation for each measurement
##Read the feature names into R
features<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/features.txt")
featureIndex<-grep(("mean\\(\\)|std\\(\\)"),features[,2])
dim(features)
dim(fullData)
fullDataSubset<-fullData[,c(1,2,featureIndex+2)]
featureNames<-as.character(features[featureIndex,]$V2)
colnames(fullDataSubset)<-c("subject","activity",featureNames)

#Uses descriptive activity names to name the activities in the data set
##Read the activity labels into R
activityLabels<-read.table("~/Desktop/Getting and cleaning data/projectData/UCI HAR Dataset/activity_labels.txt")
activityLabels<-as.character(activityLabels[,2])
fullDataSubset$activity <- activityLabels[fullDataSubset$activity]


#Appropriately labels the data set with descriptive variable names
names(fullDataSubset)<-gsub("\\()","",names(fullDataSubset))
names(fullDataSubset)<-gsub("^t","time",names(fullDataSubset))
names(fullDataSubset)<-gsub("^f","frequency",names(fullDataSubset))
names(fullDataSubset)<-gsub("timeimeime","time",names(fullDataSubset))
names(fullDataSubset)<-gsub("Gyro","Gyroscope",names(fullDataSubset))
names(fullDataSubset)<-gsub("Mag","Magnitude",names(fullDataSubset))
names(fullDataSubset)<-gsub("-","_",names(fullDataSubset))
names(fullDataSubset)<-gsub("BodyBody","Body",names(fullDataSubset))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
finalData <- fullDataSubset %>% group_by(subject,activity) %>% summarise_all(funs(mean))
write.table(finalData, file = "finalData.txt", row.names = FALSE)