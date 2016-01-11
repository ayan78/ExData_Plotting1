library(data.table)
## Read data
data <- fread("household_power_consumption.txt");

## replace the missing values as NA
data[data == "?"] <- NA
## Create date and subset relevant date range
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
sub.Data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

## Merging Time and Date into Date

sub.Data$Date <- as.POSIXct(paste(sub.Data$Date,sub.Data$Time))

## Create graph and save in png format
plot(sub.Data$Date, sub.Data$Sub_metering_1, type="l", ylab= "Energy sub metering", xlab="")
lines(sub.Data$Date, sub.Data$Sub_metering_2, type="l", col="red")
lines(sub.Data$Date, sub.Data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.copy(png,'plot3.png')
dev.off()