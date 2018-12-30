Household_Number<-c(seq(1,24,1))
Income<-c(60.0,85.5,64.8,61.5,87.0,110.1,108.0,82.8,69.0,93.0,51.0,81.0,75.0,52.8,64.8,43.2,84.0,49.2,59.4,66.0,47.4,33.0,51.0,63.0)
Lot_size<-c(18.4,16.8,21.6,20.8,23.6,19.2,17.6,22.4,20.0,20.8,22.0,20.0,19.6,20.8,17.2,20.4,17.6,17.6,16.0,18.4,16.4,18.8,14.0,14.8)
Ownership<-c(rep('Owner',12),rep('Nonowner',12))

mower.df<-data.frame(Household_Number,Income,Lot_size,Ownership)
set.seed(111)
train.index<-sample(row.names(mower.df),0.6*dim(mower.df)[1])
valid.index<-setdiff(row.names(mower.df),train.index)

train.df<-mower.df[train.index,]
valid.df<-mower.df[train.index,]

## nwe household
new.df<-data.frame(Income=60,Lot_size=20)

#scatter plot
plot(Lot_size~Income,data=train.df,pch=ifelse(train.df$Ownership=='Owner',1,3))
text(train.df$Income,train.df$Lot_size,row.names(train.df),pos=4)
text(60,20,"X")
legend("topright",c("Owner","Nonowner","newhousehold"),pch=c(1,3,4))

# initialize normalized training, validation data, complete data frames to originals
train.norm.df <- train.df
valid.norm.df <- valid.df
mower.norm.df <- mower.df

# use preProcess() from the caret package to normalize Income and Lot_Size.
library('caret')
norm.values <- preProcess(train.df[, 2:3], method=c("center", "scale"))
train.norm.df[, 2:3] <- predict(norm.values, train.df[, 2:3])
valid.norm.df[, 2:3] <- predict(norm.values, valid.df[, 2:3])
mower.norm.df[, 2:3] <- predict(norm.values, mower.df[, 2:3])
new.norm.df <- predict(norm.values, new.df[,1:2])

# use knn() to compute knn.
# knn() is available in library FNN (provides a list of the nearest neighbors)
# and library class (allows a numerical output variable).
library(FNN)
nn <- knn(train = train.norm.df[, 2:3], test = new.norm.df,
          cl = train.norm.df[, 4], k = 3)
row.names(train.df)[attr(nn, "nn.index")]

