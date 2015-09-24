rm(list=ls())

#Columns containing relevant data (means and standard deviations) based on grep() search of features.txt
alllabels <- read.table("features.txt",stringsAsFactors=F)[,2]
colToExt <- sort(setdiff(union(grep("*-mean", alllabels),grep("*-std", alllabels)),grep("*-meanFreq", alllabels)))

#Extracting relevant data from source files, and naming variables
test <- read.table("X_test.txt")[,colToExt]
train <- read.table("X_train.txt")[,colToExt]
fulldat <- rbind(test,train)
labels <- alllabels[colToExt]
names(fulldat) <- labels

#Collating info on subjects
subTest <- read.table("subject_test.txt")
subTrain <- read.table("subject_train.txt")
sub <- rbind(subTest,subTrain)

#Collating info on activities
actTest <- read.table("y_test.txt")
actTrain <- read.table("y_train.txt")
act <- rbind(actTest,actTrain)
#Descriptively naming activities
actlab <- read.table("activity_labels.txt",stringsAsFactors=F)[,2]
for(i in 1:6){
	act[which(act==i),1] <- actlab[i]
}

#Combining objects into one data object, and completely naming all columns
dat <- cbind(sub,act,fulldat)
names(dat)[1] <- "Subject"
names(dat)[2] <- "Activity"

#Determining the size of the second dataset - all subjects do all activites, so there will need to be 180 rows (30 subjects * 6 activities) in the summarized data set
length(unique(dat[,1]))
bysub <- split(dat[,2],dat[,1])
numberofactivities <- vector()
for(i in 1:length(bysub)){
	numberofactivities[i] <- length(unique(bysub[[i]]))
}

#Creating second dataset that presents averages of each extracted variable for each subject*activity 
sdat <- matrix(NA,nrow=180,ncol=dim(dat)[2])
for(i in 1:30){
	for(j in 1:6){
		#Determine which observations come from subject i and activity j to return average
		obstocollapse <- which(dat[,1]==i&dat[,2]==actlab[j])
		#Fill in new (condensed) subject column 
		sdat[j+(i-1)*6,1] <- i
		#Fill in new (condensed) activity column
		sdat[j+(i-1)*6,2] <- j
		for(k in 3:dim(dat)[2]){
			#Calculate and place averages for each subject/activity combination in appropriate place in matrix
			sdat[j+(i-1)*6,k] <- mean(dat[obstocollapse,k])
		}
	}
}
#Convert to data frame, reapply column names, and replace activity values with descriptive labels
smalldata <- as.data.frame(sdat)
names(smalldata)[1] <- "Subject"
names(smalldata)[2] <- "Activity"
names(smalldata)[3:68] <- labels
for(i in 1:6){
	smalldata[which(smalldata[,2]==i),2] <- actlab[i]
}

write.table(smalldata,file="tidy_data.txt",row.names=F)