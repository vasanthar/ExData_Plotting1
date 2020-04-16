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

# filtering the data
data2 <- filter(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

# time column
x_col <- strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# plotting the data
plot(x_col, data2$Sub_metering_1, type = 'l', xlab = "", ylab = "Energy Sub Metering")
lines(x_col, data2$Sub_metering_2, type = 'l', col = 'red')
lines(x_col, data2$Sub_metering_3, type = 'l', col = 'blue')
legend("topright", legend  = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'), border = 'black', lty = 1, bty = 'o', y.intersp = 0.1, cex = 1)

# copying the plot as png
dev.copy(png, filename = 'plot3.png', width=480, height=480)
dev.off()