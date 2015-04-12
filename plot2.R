## EXPLORATORY DATA ANALYSIS
## Project 1

# Set working directory (folder containing the data set)
# setwd("/PATH TO DIRECTORY/")

# Download data file and unzip it (deleting the compressed file)
# fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# fileName <- "./household_power_consumption.zip"
# download.file(fileUrl,fileName, method= "wget")
# unzip(fileName, overwrite= TRUE)
# unlink(fileName)

# Read data file
data <- read.table("./household_power_consumption.txt", header= TRUE, sep=";")

# Replace ? by NA
data[data=="?"] <- NA

# Create a new date/time variable
data$datetime <- strptime(paste(data$Date, data$Time), format= "%d/%m/%Y %H:%M:%S", tz="")

# Subsetting two days of data
data2days <- data[data$datetime>="2007-02-01 00:00:00" & data$datetime<"2007-02-03 00:00:00",]

# Covert data for Global_active_power into numeric
data2days$Global_active_power <- as.numeric(as.character(data2days$Global_active_power))

# Line plot
with(data2days, plot(datetime, Global_active_power, 
                     xlab= " ", ylab= "Global Active Power (kilowatts)", type= "l"))

# Save as png (480 x 480 pixels)
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()


