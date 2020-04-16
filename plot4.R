library(lubridate)
library(dplyr)

# creating data file in case it does not exist
if (!file.exists("data")){
  dir.create("data")
}

# Downloading the zip file
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile ="./data/Dataset.zip")

#unzip the data file 
unzip(zipfile = "./data./Dataset.zip", exdir = "./data")

# read the power consumption table
data <- read.table("./data./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# filter the data
data2 <- filter(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

# time column
x_col <- strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# plotting the four graphs
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# plot 1
plot(x_col, data2$Global_active_power, type = 'l', xlab = "", ylab = "Global Active Power")

# plot 2
plot(x_col, data2$Voltage, type = 'l', xlab = "datetime", ylab = "Voltage")

# plot 3
plot(x_col, data2$Sub_metering_1, type = 'l', xlab = "", ylab = "Energy Sub Metering")
lines(x_col, data2$Sub_metering_2, type = 'l', col = 'red')
lines(x_col, data2$Sub_metering_3, type = 'l', col = 'blue')

# plot 4
plot(x_col, data2$Global_reactive_power, type = 'l', xlab = "datetime", ylab = "Global_reactive_power")

# copying the data
dev.copy(png, filename = 'plot4.png', width=480, height=480)
dev.off()