# Read in files of interest from ./data
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# Read in files of interest from ./test
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt") 
subject_test <- read.table("./test/subject_test.txt")

# Combine data from ./data and ./test
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Read in features (aka column names)
features <- read.table("./features.txt")

# Determine which columns contain mean and std data
idx <- grep("mean\\(\\)|std\\(\\)", features[, 2])
X <- X[, idx]

# Tidy up column names (aka features)
names(X) <- gsub("\\(\\)", "", features[idx, 2]) # remove "()"
names(X) <- gsub("mean", "Mean", names(X)) # capitalize M
names(X) <- gsub("std", "Std", names(X)) # capitalize S
names(X) <- gsub("-", "", names(X)) # remove "-" in column names 

# Read in activity labels
activity <- read.table("./activity_labels.txt")

# Tidy up activity labels
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

# Assign activity labels
label <- activity[y[, 1], 2]
y[, 1] <- label

# Rename columns
names(y) <- "activity"
names(subject) <- "subject"

# Merge data into first dataset
clean <- cbind(subject, y, X)

# Write first dataset to file
write.table(clean, "tidy_data.txt")

# Prepare second dataset
library(data.table)
cleanDT <- data.table(clean)
calculatedData<- cleanDT[, lapply(.SD, mean), by=c("subject", "activity")]

# Write second dataset to file
write.table(calculatedData, "tidy_data_means.txt")

