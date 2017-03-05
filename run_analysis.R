##Call in Features and Activities

features <- read.table("./UCI HAR Dataset/features.txt")
featvector <- features[, 2]
##sometimes Mean is capitalized, make it lowercase with gsub
featvector2 <- gsub("Mean", "mean", featvector)

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

##Read data from the test folder 

testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")

##Use cbind to combine together

testcombo <- cbind(testsubject, ytest, xtest)

##Read data from the train folder

trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

##Use cbind to combine together

traincombo <- cbind(trainsubject, ytrain, xtrain)

##Then combine the test and train sets, test set on top

fullset <- rbind(testcombo, traincombo)

##Now we have a full set with a total of 10299 rows
##and 563 columns. The first column is the person identifier (numbers 1 to 30) and
## the second column is the activity identifier (numbers 1 to 6). 
##The following 561 columns are each of the features. 

##We only need the ones related to mean and standard deviation

names(fullset)[(1)] <- str_c("subject")
names(fullset)[(2)] <- str_c("activity")
names(fullset)[-(1:2)] <- str_c(featvector2)
##This names the first column subject, 2nd column activity, and the remaining 
##columns the names of the features

x <- c("mean", "std", "subject", "activity")
grepl(paste(x, collapse = "|"), names(fullset))
##Create the vector x, then grepl is an example a vector that shows TRUE if the 
## names contain "mean", "std", "subject", or "activity" 
##We can use it to subset the columns we want: 

fullsubset <- fullset[, grepl(paste(x, collapse = "|"), names(fullset))]

##Use the factor function and the activities table to assign the numerical values
##in our data table the corresponding text value (walking, etc.)

fullsubset$activity <- factor(fullsubset$activity, levels = activities[, 1], labels = activities[, 2])

##Create a new tidy dataset that has the average of each variable for each 
##activity and subject and order it first by subject and then activity

tidyset <- aggregate(. ~ subject + activity, fullsubset, mean)
tidyset <- tidyset[order(tidyset$subject, tidyset$activity), ]

write.table(tidyset, "tidyset.txt", row.name = FALSE)

