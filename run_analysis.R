# Course Project - Getting and Cleaning Data - JKC

test_x <- read.table(file = "UCI HAR Dataset/test/X_test.txt", header = FALSE);
test_y <- read.table(file = "UCI HAR Dataset/test/y_test.txt", header = FALSE);
test_subject <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = FALSE);
feature_names <- read.table(file = "UCI HAR Dataset/features.txt", header = FALSE);
colnames(test_x) <- feature_names$V2;
colnames(test_y) <- "ActivityLabel";
colnames(test_subject) <- "Subject"

train_x <- read.table(file = "UCI HAR Dataset/train/X_train.txt", header = FALSE);
train_y <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = FALSE);
train_subject <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = FALSE);
colnames(train_x) <- feature_names$V2;
colnames(train_y) <- "ActivityLabel";
colnames(train_subject) <- "Subject"

combined_x <- rbind(test_x, train_x)
combined_y <- rbind(test_y, train_y)
combined_subj <- rbind(test_subject, train_subject)

colsNeeded <- c(
  rep(x = seq(from = 1, to = 90, by = 20), each = 6)+(0:5),
  rep(x = seq(from = 121, to = 200, by = 40), each = 6)+(0:5),
  rep(x = seq(from = 201, to = 260, by = 13), each = 2)+(0:1),
  rep(x = seq(from = 266, to = 500, by = 79), each = 6)+(0:5),
  rep(x = seq(from = 503, to = 550, by = 13), each = 2)+(0:1)
);

MeanStdevData <- combined_x[colsNeeded];
MeanStdevData$Subject <- as.numeric(combined_subj[,]);
MeanStdevData$ActivityLabel <- as.numeric(combined_y[,]);

SummaryData <- aggregate(x = MeanStdevData, by = list(MeanStdevData$Subject, MeanStdevData$ActivityLabel), FUN = mean)

write.table(MeanStdevData, file = "TidyData.txt", row.names = FALSE)
write.table(SummaryData, file = "TidyData_Summary.txt", row.names = FALSE)
