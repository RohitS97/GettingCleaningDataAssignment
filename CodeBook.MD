---
output:
  pdf_document: default
  html_document: default
---
#Code Book

##Getting and Cleaning Data Assignment

Initially we have downloaded the zip file containing the datasets and unzipped it into our Working Directory which is linked to the GitHub Repository

```{r,eval=FALSE}
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("./UCI HAR Dataset/train/Y_train.txt")
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("./UCI HAR Dataset/test/Y_test.txt")
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
actlabels<-read.table("./UCI HAR Dataset/activity_labels.txt")

```

###Variables
**xtrain** : Dataset containing Training Set

**ytrain** : Dataset containing Training Labels

**subtrain** : Dataset in which Each row identifies the subject who performed the activity for each window sample

**xtest** : Dataset containing Test Set

**ytest** : Dataset containing Test Labels

**subtest** : Dataset in which Each row identifies the subject who performed the activity for each window sample

**features** : Dataset containing list of all features

**actlabels** : Dataset containing label and it's corresponding activity name

```{r,eval=FALSE}
train<-cbind(subtrain,ytrain,xtrain)
test<-cbind(subtest,ytest,xtest)
##features
xtname<-c('subid','actid',features[,2])
##xtname
colnames(train)<-xtname
colnames(test)<-xtname
##actlabels
colnames(actlabels)<-c('actid','activityname')
combined<-rbind(train,test)

```


**train and test** : These are the datasets containing all the data regarding training and test sets

**xtname** : Contains the name of all variable names (column names) of the data set

**combined** : The merged dataset containaing all the test and training data with activity names

**comb** : Subset dataset of Combined which has the Acitivity Id, Subject Id, Columns having means and standard deviations

```{r, eval=FALSE}
checkname<-grepl("subid",colnames(combined))|grepl("actid",colnames(combined))|grepl("mean..",colnames(combined))|grepl("sd..",colnames(combined))
comb<-combined[,checkname]
finaldf<-merge(actlabels,comb,by="actid",all.x = TRUE)
tidydataset <- aggregate(. ~actid+subid+activityname,finaldf, mean)
tidydataset<-tidydataset[order(tidydataset$actid,tidydataset$subid),]
write.table(tidydataset, "tidydataset.txt")
```

**tidydataset** : Output data set having a independent tidy data set with the average of each variable for each activity and each subject.

