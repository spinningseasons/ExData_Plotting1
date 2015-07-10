## Create Plot 3 for Coursera Data Science Exploratory Data Analysis Course Project 1
## Updated 07.09.15


#Load important packages
library(data.table)
library(dplyr)
library(lubridate)

#Load in data
hcp <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", header = TRUE, sep=";", na.strings="?")

#Convert to date class
hcp$Date=as.Date(hcp$Date,"%d/%m/%Y")

#Filter out appropriate dates and merge into one dataset
hcpa <- filter(hcp, Date=="2007-02-01")
hcpb <- filter(hcp, Date=="2007-02-02")
hcp2 <- rbind(hcpa,hcpb)

#Convert Time to period class and merge with date into one variable 
hcp2$DateTime=ymd_hms(paste(hcp2$Date,hcp2$Time))

#Reformat data organization to prepare for plotting
sub_1=select(hcp2,c(DateTime,Sub_metering_1))
sub_1 <- rename(sub_1, SM=Sub_metering_1)
sub_1 <- mutate(sub_1, smType = "Sub_metering_1")

sub_2=select(hcp2,c(DateTime,Sub_metering_2))
sub_2 <- rename(sub_2, SM=Sub_metering_2)
sub_2 <- mutate(sub_2, smType = "Sub_metering_2")

sub_3=select(hcp2,c(DateTime,Sub_metering_3))
sub_3 <- rename(sub_3, SM=Sub_metering_3)
sub_3 <- mutate(sub_3, smType = "Sub_metering_3")

#Combine together and treat smType as a factor
hcp3 <- rbind(sub_1,sub_2,sub_3)
hcp3$smType=as.factor(hcp3$smType)

#Open graphics device
png("plot3.png", width=480, height=480)

#Plot
par(mfcol = c(1,1))
with(hcp3,plot(DateTime,SM,type="n",ylab="Energy sub metering",xlab=""))
with(subset(hcp3,smType=="Sub_metering_1"),lines(DateTime,SM))
with(subset(hcp3,smType=="Sub_metering_2"),lines(DateTime,SM, col="red"))
with(subset(hcp3,smType=="Sub_metering_3"),lines(DateTime,SM, col="blue"))
legend("topright", lty = 1, col = c("black","blue","red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
