# Read the data into R and set the column names

Energy <- read.table("./Coursera/Exploratory Data Analysis With R/Programming Assignment 1/household_power_consumption.txt", sep=";", skip = 1)
names(Energy) <- c("Date","Time","Global_active_power","Global_reactive_power","
                   Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


# Get subset of data for the two dates required
Energy <- subset(Energy, Energy$Date == "1/2/2007" | Energy$Date == "2/2/2007")


# Concatenate Date and Time into one field and convert into a datetime field
library(dplyr)
Energy <- mutate(Energy, DT = paste(Date, Time, sep = " "))


# Load lubridate package and set Date and Time as Date variables
library(lubridate)
Energy$Date <- dmy(Energy$Date)
Energy$DT <- dmy_hms(Energy$DT)


# Set active device to png and export file location
png("./Coursera/Exploratory Data Analysis With R/Programming Assignment 1/ExData_Plotting1/plot4.png", 480, 480)
par(mfrow = c(2,2))

# Create 1st plot with Global Active Power
with(Energy, plot(DT, Global_active_power, pch = "", 
                  xlab = "", ylab = "Golabal Active Power"))
lines(Energy$DT, Energy$Global_active_power)


# Create 2nd plot with voltage
with(Energy, plot(DT, Energy[[5]], pch = "", 
                  xlab = "datetime", ylab = "Voltage"))
lines(Energy$DT, Energy[[5]])


# Create 3rd plot with sub meters
with(Energy, plot(DT, as.numeric(as.character(Sub_metering_1)), pch = "", xlab = "", ylab = "Energy sub metering"),
     plot(DT, as.numeric(as.character(Sub_metering_2)), pch = ""),
     plot(DT, Sub_metering_3, pch = ""))
lines(Energy$DT, as.numeric(as.character(Energy$Sub_metering_1)))
lines(Energy$DT, as.numeric(as.character(Energy$Sub_metering_2)), col = "red")
lines(Energy$DT, Energy$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), bty = "n", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


# Create 4th plot with Global Reactive Power
with(Energy, plot(DT, Global_reactive_power, pch = "", xlab = "datetime"))
 lines(Energy$DT, Energy$Global_reactive_power)


# Turn png device off
dev.off()

