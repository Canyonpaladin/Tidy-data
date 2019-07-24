filepath = file.path("C:/Users/HP/Desktop/Data")
setwd(filepath)
if(!file.exists("4_W4P")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  , "4_W4P")
  unzip("4_W4P")
}
setwd("UCI HAR Dataset")
activity <- read.table("activity_labels.txt", col.names = c("codes", "activity"))
feature <- read.table("features.txt", col.names = c("n","functions"))
subject_test <- read.table("test/subject_test.txt", col.names = "subjects")
x_test <- read.table("test/X_test.txt", col.names = feature$functions)
y_test <- read.table("test/y_test.txt", col.names = "codes")
subject_train <- read.table("train/subject_train.txt", col.names = "subjects")
x_train <- read.table("train/X_train.txt", col.names = feature$functions)
y_train <- read.table("train/y_train.txt", col.names = "codes")
# Merging
subject <- rbind(subject_test, subject_train)
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
fin <- cbind(subject, x, y)
# Extracting
q <- grep("mean|std", names(fin)) 
library(dplyr)
c <- select(fin, 563, 1, q)
# Describing
data <- merge(activity, q, by = "codes")
data2 <- select(data, -1)
# Labeling What are these supposed to mean?! I'm crying...
names(data2) <- gsub("activity", "Activity", names(data2))
# Whatever
result <- tbl_df(data2) %>% group_by(Activity, subjects) %>% summarize_all(mean)
View(result)

