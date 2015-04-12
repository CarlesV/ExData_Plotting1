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

# Covert data into numeric
data2days$Global_active_power <- as.numeric(as.character(data2days$Global_active_power))
data2days$Global_reactive_power <- as.numeric(as.character(data2days$Global_reactive_power))
data2days$Voltage <- as.numeric(as.character(data2days$Voltage))
data2days$Sub_metering_1 <- as.numeric(as.character(data2days$Sub_metering_1))
data2days$Sub_metering_2 <- as.numeric(as.character(data2days$Sub_metering_2))
data2days$Sub_metering_3 <- as.numeric(as.character(data2days$Sub_metering_3))

# Select png as graphics device (480 x 480 pixels). To avoid truccating the legend when passing it to png, 
# I create the figure as png instead of saving it later
dev.copy(png, file = "plot4.png", width = 480, height = 480)

# Prepare multiple plots
par(mfrow = c(2, 2))
with(data2days, {
     plot(datetime, Global_active_power, xlab= " ", ylab= "Global Active Power", type= "l")
     plot(datetime, Voltage, type= "l")
     plot(datetime, Sub_metering_1, xlab= " ", ylab= "Energy sub metering", type= "n")
     lines(datetime, Sub_metering_1, col= "black")
     lines(datetime, Sub_metering_2, col= "red")
     lines(datetime, Sub_metering_3, col= "blue")
     legend("topright", border="", lty=1, bty="n", col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex= 0.75)
     plot(datetime, Global_reactive_power, type= "l")
})

# Save as png (480 x 480 pixels)
dev.off()
