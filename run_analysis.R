library(dplyr)

setwd(paste0(getwd(), "/gacd-peer-project/UCI HAR Dataset"))

# Read in the datasets as is at first.
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity_name")
features <- read.table("features.txt")
colnames(features) <- c("column_index", "column_name")

# Test data
subject_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
test <- cbind(subject_test, y_test, x_test)

# Train data
subject_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
train <- cbind(subject_train, y_train, x_train)

# Merge the data sets together
m_set <- rbind(train, test)
# Set the column names from the features data set
colnames(m_set) <- append(as.character(features$column_name), c("subject", "activity"), after = 0)

# Get only the mean and standard deviation activity measurements from the data
m_set <- m_set[, append(grep("mean|std", colnames(m_set)), 1:2, after = 0)]

m_set <- merge(m_set, activity_labels, by.x = "activity", by.y = "activity_id")

# Clean up the column names
cleaned_cols <- tolower(colnames(m_set))
cleaned_cols <- gsub("-", "_", cleaned_cols)
cleaned_cols <- sub("tbody", "rawbody", cleaned_cols)
cleaned_cols <- sub("tgravity", "rawgravity", cleaned_cols)
cleaned_cols <- sub("fbody", "feature", cleaned_cols)
cleaned_cols <- sub("\\(\\)", "", cleaned_cols)
colnames(m_set) <- cleaned_cols

# Shift around the column names in m_set to make it a little bit cleaner
m_set <- subset(m_set, select = c(activity, subject, activity_name, rawbodyacc_mean_x:featurebodygyrojerkmag_meanfreq))

activity_subject_means <- m_set %>%
                            select(-activity_name) %>%
                            group_by(subject, activity) %>%
                            summarize_each(funs(mean)) %>%
                            ungroup()

activity_subject_means <- merge(activity_subject_means, activity_labels, by.x = "activity", by.y = "activity_id")

write.table(activity_subject_means, file = "activity_subject_means.txt", row.names = FALSE)
                