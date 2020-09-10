##Reading all required datasets into R

xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("./UCI HAR Dataset/train/Y_train.txt")
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("./UCI HAR Dataset/test/Y_test.txt")
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
actlabels<-read.table("./UCI HAR Dataset/activity_labels.txt")

train<-cbind(subtrain,ytrain,xtrain)  ##Assembling all different training datasets
test<-cbind(subtest,ytest,xtest)  ##Assembling all different test datasets
##features
xtname<-c('subid','actid',features[,2])
##xtname

##Adding descriptive names to the variables of test and training datasets
colnames(train)<-xtname
colnames(test)<-xtname
##actlabels
colnames(actlabels)<-c('actid','activityname')

combined<-rbind(train,test)  ##Creating a combined dataset of test and training datasets
checkname<-grepl("subid",colnames(combined))|grepl("actid",colnames(combined))|grepl("mean..",colnames(combined))|grepl("sd..",colnames(combined))
comb<-combined[,checkname]

##Merging the combined dataset with activity names
finaldf<-merge(actlabels,comb,by="actid",all.x = TRUE)

##Creating and ordering the final tidy dataset by activity and subject
tidydataset <- aggregate(. ~actid+subid+activityname,finaldf, mean)
tidydataset<-tidydataset[order(tidydataset$actid,tidydataset$subid),]

##Writing the tidy dataset into text files
write.table(tidydataset, "tidydataset.txt", row.names = FALSE)