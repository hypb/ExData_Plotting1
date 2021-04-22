
library(lubridate)
library(dplyr)
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp<-tempfile()
download.file(url, temp, method="curl")
data<- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)
rm(temp, url)

data<- mutate(data, dates=dmy(data$Date))
data<- filter(data, dates>=as.Date('2007-02-01') & dates<=as.Date('2007-02-02'))

data$Global_active_power<- sub("?", "", data$Global_active_power)
data$Global_active_power<- as.numeric(data$Global_active_power)

## Histogram of global active power

hist(data$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

##Save it to PNG file with a width of 480 pixels and a height of 480 pixels

dev.copy(png, file="plot1.png", width=480, height=480, units="px")
dev.off()
