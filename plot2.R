library(data.table)
library(dplyr)

#read data
data <- fread("household_power_consumption.txt", sep=";")

#subset data
data <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

#convert to datetime
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$datetime <- paste0(data$Date," ",data$Time)
data$datetime <- as.POSIXct(strptime(data$datetime, "%Y-%m-%d %H:%M:%S"))

data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot2.png")
plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()