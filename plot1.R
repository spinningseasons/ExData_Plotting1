## Create Plot 1 for Coursera Data Science Exploratory Data Analysis Course Project 1
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

#Create plot and save
par(mfcol = c(1,1))
hist(hcp2$Global_active_power, col="red", main ="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png")
dev.off()