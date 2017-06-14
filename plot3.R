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
png("./Coursera/Exploratory Data Analysis With R/Programming Assignment 1/ExData_Plotting1/plot3.png", 480, 480)


# Create scatterplot with no points for 3 variables, and the lines for those variables
# Also set sub_metering 1 and 2 as numeric variables because the graph will look different if they stay as factors
with(Energy, plot(DT, as.numeric(as.character(Sub_metering_1)), pch = "", xlab = "", ylab = "Energy sub metering"),
            plot(DT, as.numeric(as.character(Sub_metering_2)), pch = ""),
            plot(DT, Sub_metering_3, pch = ""))
 lines(Energy$DT, as.numeric(as.character(Energy$Sub_metering_1)))
 lines(Energy$DT, as.numeric(as.character(Energy$Sub_metering_2)), col = "red")
 lines(Energy$DT, Energy$Sub_metering_3, col = "blue")
 
 
# Add legend to plot
 legend("topright", lty = 1, col = c("black","red","blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


# Turn png device off
dev.off()

