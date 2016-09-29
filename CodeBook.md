# Analysis

First `run_analysis.R` will load in the data from the activity labels and features and set their column names to something more meaningful. After that the script loads in the X, y, and subject data for both the _training_ and _test_ data sets and bind their columns together in order to put their data into two sources: `test` and `train`. I used `cbind()` for this operation because the description of the data detailed that the files contained data in the same order as the observations.

The script then merges the `train` and `test` data sets together using `rbind` because the two data sets have the same column dimensions. The resulting `data.frame` is stored in `m_set`.

Next, it makes the column names of `m_set` more easy to read by taking the 2nd column of the data in `features.txt` (stored in the script as `features`) and adds a vector containg the character strings `"subject"` and `"activity"` to the front of the vector of information from that column. In order to select only the columns that have information on the mean and standard deviation of measurements, columns from `m_set` are then selected using `grep()`. 

Activity labels are added to `m_set` by merging the data from `activitiy_labels.txt` and the column names are cleaned by converting to lower case, replacing hyphens with underscores, and refining the wording in the columns.

The final processing that the script does is grouping `m_set` by `subject` and `acitivity` and then using `summarize_each` from the `dplyr` package to get the mean of all of the measurement columns. `activity_subject_means` stores the result of this operation.