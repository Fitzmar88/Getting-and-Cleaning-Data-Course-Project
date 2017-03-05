
# Data and Variables

Data is taken from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The three types of variables are...

1. Subjects. These are the individuals who participated in an experiment and are represented by numbers 1 to 30. 
2. Activities. These are the 6 different types of activities a subject could be doing walking, walking upstairs, walking downstairs, sitting, standing, and laying. They are represented by the numbers 1 through 6 respectively.
3. Measurements (or Features). These are the different measurements of movement of the smartphone data and the means and standard deviations, among other metrics, were measured of these signals. They result 561 unique variables of which we only want variables related to mean and standard deviation. 

The data is partitioned into two sets: a training data set and a test data set. The purpose of the exercise is to combine the individual files into one tidy data set, remove all variables that aren't test subjects, activities, or measurements that are either a mean or standard deviation. Once this dataset is finished, I created a final tidy dataset that shows the mean of measurements for each unique pair of subject and activity. 

# Transformations

Data from subject_test.txt, X_test.txt, and y_test.txt are combined into one test set so that each measurement is assigned its appropriate subject and activity. The same is done for subject_train.txt, X_train.txt, and y_train.txt to create one train set. 

features.txt and activity_labels.txt are also called into R as they provided the proper labels for the corresponding number codes for activities and measurements. 

The test set and training set are then combined. Then we delete all measurements (or features) that are unrelated to mean or standard deviation. Qualitative activity labels (walking, walking upstairs, etc.) are assigned to the observations based on their corresponding number label. Finally, the aggregate function is used to find the mean for each unique pair of subjects and activities. This process is described in run_analysis.R and the final output is shown in tidydata.txt



