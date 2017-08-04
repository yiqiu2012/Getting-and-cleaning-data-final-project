Codebook.md
This document describes the code inside run_analysis.R

The data manipulated by this code represents data collected from the accelerometers and gyroscope of the Samsung Galaxy S smartphone. The data are grouped into files labeld as "test" and "train", wHich contain txt files with the prefix "X" and "y". In addition, there are txt files providing extra info such as "activity_labels.txt", "feature_info.txt", and "README.txt".

The code is splitted in the following sections:
-Downloading and loading the data
-Manipulating the data 
-Writing the data as requried to a CSV file

Downloading and loading the data
-Check if the file exsits in current working directory. If not, download the file "UCI HAR Dataset" zip file using download.file function.
-Unzip the file and read the datasets contained in the txt files into variables with the same name. For example, read "X_train.txt" into "train.x", "y_train.txt" into "train.y", and etc..

Manipulating the data
-Merge the training and the test sets to create one data set called "fullData"
-Extract only the measurements on the mean and standard deviation for each measurements using feature labels provided in "features.txt". Store them in "fullDataSubset"
-Uses descriptive activity names contained in the "activity_labels.txt" file to name the activities in the data set. 
-Approriately labels the data set using "gsub" function.
-Create an independent tidy data set with each variable for each activity and each subject using "group_by" and "summarise_each" functions in the "dplyr" package. Write them out in txt file.



 