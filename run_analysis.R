file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "Coursera_DS3_Final.zip"
if (!file.exists(zip_file)) { 
	download.file(file_url, destfile = zip_file, method = "curl") 
	}
if (!file.exists("UCI HAR Dataset")) { 
	unzip(zip_file) 
	}

##Step 1
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table ("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") 
x_test <- read.table("UCI HAR Dataset/test/X_test.txt") 
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_merged <- rbind(subject_train, subject_test)
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)

full_data <- cbind(subject_merged, y_merged, x_merged)

##Step 2

features <- read.table("UCI HAR Dataset/features.txt")
targetcols <- grep("mean|std", features$V2)
x_extracted <- x_merged[, targetcols]
full_data <- cbind(subject_merged, y_merged, x_extracted)

##Step 3

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
full_data[,2] <- factor(full_data[,2], levels = activities$V1, labels = activities$V2)

##Step 4

names(full_data)[1] <- "subject"
names(full_data)[2] = "activity"
math_col_names <- features$V2[targetcols]
math_col_names <- gsub("\\(\\)", "", math_col_names)
math_col_names <- gsub("^t", "Time", math_col_names)
math_col_names <- gsub("^f", "Frequency", math_col_names)
names(full_data)[3:ncol(full_data)] <- math_col_names

##Step 5

library(dplyr)
final_tidy_data <- full_data %>%
group_by(subject, activity) %>%
summarize_all(mean)

write.table(final_tidy_data, "tidy_data.txt", row.name = FALSE)