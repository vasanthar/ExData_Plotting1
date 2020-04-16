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

# plotting and saving the data
hist(as.numeric(data2$Global_active_power), ylim = c(0,1200), col = 'red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# copying the plot
dev.copy(png, filename = 'plot1.png', width=480, height=480)
dev.off()