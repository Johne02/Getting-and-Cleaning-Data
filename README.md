# Getting-and-Cleaning-Data
Repository for the assignment of the Getting and Cleaning Data course on Coursera

How the code works:

Data Download & Setup

First of all, I save the URL in an object called file_url. Then I choose to name the zip file Coursera_DS3_Final.zip by doing zip_file <- "Coursera_DS3_Final.zip".
Then I check if the file already exists and if it doesn't, then I download it from the URL using if (!file.exists(zip_file)) { download.file(file_url, destfile = zip_file, method = "curl") }.
Then I look for the folder inside it and if it doesn't exist, I unzip the file.

Step 1: Merging the data sets
I read the subject_train.txt using the read.table function and save it as subject_train. I do the same for the data on X_train and y_train and save them as x_train and y_train respectively. I continue to do the exact same for the test folder and data sets.
In order to merge these datasets, I use rbind for the subject, train and test txt files and create a full_data object where I bind all the columns of the merged data sets using cbind(subject_merged, y_merged, x_merged).

Step 2: Extracting mean and standard deviation
I read the features dataset to figure out which columns refer to mean and std values. I save the name of all the columns in the object features and create a new object called targetcols where I search in the second column of the features dataset the columns containing mean or std.
After I figure out the number of these columns, I create an object called x_extracted, where I specifically isolate the columns I am interested in from the x_merged dataset I created before.
Finally, I update my full_data dataset to include only the columns I was instructed to keep using cbind again, but with x_extracted instead of x_merged this time.

Step 3: Applying activity labels
I simply read the table with the labels of the activities and save it in the object called activities.
I then create a factor used in the second column of the full_data set which will replace the numbers (levels) with the name of the activities (labels) using the activities dataset as reference.

Step 4: Labeling with descriptive variable names
I initially change the first and second columns of my dataset to subject and activity respectively.
Then I save the column names I am interested in from the features dataset I saved previously into a new object called math_col_names.
The next few coding lines are purely to make the names more tidy by removing parentheses, replacing t with Time and f with Frequency.
Finally, I change the names of the full_data dataset from the 3rd column onwards (as I already changed the first 2 column names in the beginning) with the names included in the math_col_names object.

Step 5: Creating the final tidy dataset
I initially load the dplyr package and then group_by my dataset by subject and activity and use the summarize_all(mean) function to generate a new dataset which is grouped by subject and activity and the mean for each activity is calculated.
Finally, I create the tidy_data.txt file using the write.table function.
