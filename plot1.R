# Read the data into R and set the column names

Energy <- read.table("./Coursera/Exploratory Data Analysis With R/Programming Assignment 1/household_power_consumption.txt", sep=";", skip = 1)
names(Energy) <- c("Date","Time","Global_active_power","Global_reactive_power","
                   Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


# Get subset of data for the two dates required
Energy <- subset(Energy, Energy$Date == "1/2/2007" | Energy$Date == "2/2/2007")


# Load lubridate package and set Date and Time as Date variables
library(lubridate)
Energy$Date <- dmy(Energy$Date)
Energy$Time <- hms(Energy$Time)
Energy$Time <- paste(hour(Energy$Time),minute(Energy$Time),second(Energy$Time),sep=":")


# Set active device to png and export file location
png("./Coursera/Exploratory Data Analysis With R/Programming Assignment 1/ExData_Plotting1/plot1.png", 480, 480)


# Plot the histogram, adjust the x axis, color, label, and title
hist(as.numeric(as.character(Energy$Global_active_power)), col="red", 
     xlab = "Global Active Power(kilowatts)", main = "Global Active Power")


# Turn png device off
dev.off()

