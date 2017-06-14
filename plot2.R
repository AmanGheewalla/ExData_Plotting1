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
png("./Coursera/Exploratory Data Analysis With R/Programming Assignment 1/ExData_Plotting1/plot2.png", 480, 480)


# Create scatterplot with no points, proper labels, and add a line through where the points would be
with(Energy, plot(DT, Global_active_power, pch = "", 
                  xlab = "", ylab = "Golabal Active Power (kilowatts)"))
lines(Energy$DT, Energy$Global_active_power)


# Turn png device off
dev.off()

