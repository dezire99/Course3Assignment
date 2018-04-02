## Codebook

# Procedure & Transformation
* Load the available data
	1. The test data is loaded to the workspace using read.table() and assigned to the variabes "X_test", "y_test" and "subject_test".
	2. The training data is loaded to the workspace using read.table() and assigned to the variabes "X_train", "y_train" and "subject_train".
	3. The list of features is loaded to the workspace using read.table() and assigned to the variable "features". Since the features dataset has two columns, the column names are appropriately assigned as "SerialNum" and "FeatureName" using colnames().

*  Merge the training and the test sets to create one data set.
	1. The variables "X_merge", "y_merge" and "subject_merge" contain the data merged from the test and training datasets loaded in previous steps. The data merging is done using the rbind() command.
	
* Extract only the measurements on the mean and standard deviation for each measurement.
	1. grep() is used with regular expression "std[()]|mean[()]" to obtain only those columns which correspond to the mean and standard deviation for each measurement. 
	2. "X_reqd" is the resulting subset of the merged data.
	
* Use descriptive activity names to name the activities in the data set
	1. factor() command is used on the activities listed in "y_merge". 
	2. The descriptive activity names are c("Walking","WalkingUpstairs","WalkingDownstairs","Sitting","Standing","Laying") which correspond to c(1,2,3,4,5,6) in "y_merge".
	3. The descriptive activity names are then added as a column to X_reqd. The column name is "Activity". You can access the column using X_reqd$Activity.
	
* Appropriately label the data set with descriptive variable names.
	1 . Only the relevant column names corresponding to mean and standard deviation for each measurement are obtained in the variable "my_colnames".
	2. In my_colnames, "-mean()" is replaced by  "Mean" using the gsub() command.
	3. In my_colnames, "-std()" is replaced by  "Std" using the gsub() command.
	4. In my_colnames, "-X" is replaced by  "X" using the gsub() command.
	5. In my_colnames, "-Y" is replaced by  "Y" using the gsub() command.
	6. In my_colnames, "-Z" is replaced by  "Z" using the gsub() command.
	7. Finally, "my_colnames" is assigned as column names for X_reqd using colnames() command.
	
* Add the subject details to the X_reqd data frame
	1. The merged subject values are added to the "X_reqd" dataset under column name "Subject".
	
* create a second, independent tidy data set with the average of each variable for each activity and each subject.
	1. The chaining feature is used here.
	2. The "X_reqd" data frame is first grouped on the basis of Subject and Activity using group_by() command.
	3. Finally, summarize_all("Mean") is used to obtain the mean for each group.
	
* Write the tidy independent data set a text file
	1. write.table() with row.names = FALSE is used to write the tidy dataset to "Tidy_data.txt"
	
# Variables
* X_test = Data frame containing dataset provided in X_test.txt
* y_test = Data frame containing dataset provided in y_test.txt
* subject_test = Data frame containing dataset provided in subject_test.txt
* X_train = Data frame containing dataset provided in X_train.txt
* y_train = Data frame containing dataset provided in y_train.txt
* subject_train = Data frame containing dataset provided in subject_train.txt
* features = Data frame containing dataset provided in features.txt	
* X_merge = Data frame obtained by merging X_test and X_train.
* y_merge = Data frame obtained by merging y_test and y_train.
* subject_merge = Data frame obtained by merging subject_test and subject_train.
* X_reqd = Data frame containing only those features corresponding to mean and standard deviation for all measurements. In addition it also contains the Subject and Activity columns.
* my_colnames = Character list containing all feature names corresponding to mean and standard deviation for all measurements.
* Data_tidy = Tibble which is the tidy, independent dataset with the average of each variable for each activity and each subject.
 
	

	
	
	