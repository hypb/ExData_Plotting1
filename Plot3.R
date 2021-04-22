
library(lubridate)
library(dplyr)
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp<-tempfile()
download.file(url, temp, method="curl")
data<- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)
rm(temp, url)

data<- mutate(data, dates=dmy(data$Date))
data<- mutate(data, times=hms(data$Time))
data<- filter(data, dates>=as.Date('2007-02-01') & dates<=as.Date('2007-02-02'))
data<- mutate(data, newtime=dates + times)

data$Sub_metering_1<- sub("?", "", data$Sub_metering_1)
data$Sub_metering_1<- as.numeric(data$Sub_metering_1)
data$Sub_metering_2<- sub("?", "", data$Sub_metering_2)
data$Sub_metering_2<- as.numeric(data$Sub_metering_2)

##Construct the plot

plot(data$newtime, data$Sub_metering_1, type = "l", col="black", xlab = "", ylab = "Energy sub metering")
lines(data$newtime, data$Sub_metering_2, type = "l", col="red")
lines(data$newtime, data$Sub_metering_3, type = "l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty = 1)

##Save it to PNG file with a width of 480 pixels and a height of 480 pixels

dev.copy(png, file="plot3.png", width=480, height=480, units="px")
dev.off()
