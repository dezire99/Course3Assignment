library(dplyr)

# Read the test data sets
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "",header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep = "",header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "",header = FALSE)

# Read the train data sets
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "",header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep = "",header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = "",header = FALSE)

# Read the file features.txt to obtain a list of the features
features <- read.table("./UCI HAR Dataset/features.txt", sep = "",header = FALSE)
colnames(features) <- c("SerialNum","FeatureName")

# 1. Merge the training and the test sets to create one data set.
X_merge <- rbind(X_test,X_train)
y_merge <- rbind(y_test,y_train)
subject_merge <- rbind(subject_test,subject_train)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
X_reqd <- X_merge[,grep("std[()]|mean[()]",features$FeatureName)]

# 3. Use descriptive activity names to name the activities in the data set
X_reqd$Activity <- factor(y_merge[[1]],labels=c("Walking","WalkingUpstairs","WalkingDownstairs","Sitting","Standing","Laying"))

# 4. Appropriately label the data set with descriptive variable names.
my_colnames <- as.character(features$FeatureName)[grep("std[()]|mean[()]",as.character(features$FeatureName))]
# Replace -mean() with Mean, -std() with Std, -X with X and so on
my_colnames <- gsub("-mean[(][)]","Mean",my_colnames)
my_colnames <- gsub("-std[(][)]","Std",my_colnames)
my_colnames <- gsub("-X","X",my_colnames)
my_colnames <- gsub("-Y","Y",my_colnames)
my_colnames <- gsub("-Z","Z",my_colnames)
colnames(X_reqd) <- c(my_colnames,"Activity")

# Also add the subject details to the X_reqd data frame
X_reqd$Subject <- factor(subject_merge[[1]])

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
Data_tidy <- X_reqd %>% 
        group_by(Activity,Subject) %>%
        summarize_all("mean")

# Write the tidy independent data set to Tidy_data.txt
write.table(Data_tidy,"./Tidy_data.txt",row.name = FALSE)


