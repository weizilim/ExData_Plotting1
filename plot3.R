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

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

png("plot3.png")
plot(data$datetime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("Black", "red", "blue"), 
       lty=c(1,1,1))
dev.off()