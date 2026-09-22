# Code Book: Human Activity Recognition Tidy Dataset

## 1. Project Overview
This dataset is a summarized tidy version of the "Human Activity Recognition Using Smartphones" dataset. The original data was collected from 30 volunteers (ages 19-48) wearing a Samsung Galaxy S II smartphone on their waist while performing six standard activities. The phone's embedded accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity.

## 2. Data Processing (Transformations)
The `run_analysis.R` script performs the following transformations to clean and summarize the data:

1. **Merge the data:** The training and test sets were combined to create one full dataset (`subject`, `X` measurements, and `y` activities).
2. **Extract target variables:** Using the `grep` function, only the measurements containing the strings `"mean"` or `"std"` were extracted. *(Note: Because `ignore.case = FALSE` and no parenthesis strictly defined the search, this extraction intentionally includes `meanFreq` variables as well).*
3. **Apply descriptive activity names:** The numeric activity codes (1-6) were replaced with descriptive factors from the `activity_labels.txt` file (e.g., WALKING, SITTING).
4. **Clean variable names:** Column headers were cleaned for better readability:
   * Removed empty parentheses `()` 
   * Replaced starting `t` with `Time`
   * Replaced starting `f` with `Frequency`
5. **Create the final tidy dataset:** The data was grouped by `subject` and `activity`. The final dataset (`tidy_data.txt`) contains the mathematical average of each variable for each group.

## 3. Data Dictionary
The final dataset contains 180 rows (30 subjects × 6 activities) and 81 columns. 

### Identifiers
* `subject`: The ID number of the volunteer who performed the activity. Ranged from 1 to 30.
* `activity`: The name of the physical activity performed. Factor with 6 levels:
  1. WALKING
  2. WALKING_UPSTAIRS
  3. WALKING_DOWNSTAIRS
  4. SITTING
  5. STANDING
  6. LAYING

### Measurements
All remaining 79 columns are the **average** of the original measurements for that specific subject and activity. 
* *Units:* All original features were normalized and bounded within [-1, 1], meaning these averages are unitless.
* *Naming Convention:* 
  * `Time`: Time domain signal
  * `Frequency`: Frequency domain signal (Fast Fourier Transform applied)
  * `Acc`: Accelerometer measurement
  * `Gyro`: Gyroscope measurement
  * `Mag`: Magnitude of the signals
  * `mean`: Mean value
  * `std`: Standard deviation
  * `X, Y, Z`: 3-axial signals in the X, Y, and Z directions
