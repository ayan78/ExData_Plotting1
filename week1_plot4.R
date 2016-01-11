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
png(file = "plot4.png", width = 480, height = 480, units = "px")

## Create graph and save in png format
par(mfrow = c(2, 2),mai=c(0.4,0.4,0.4,0.4))

## [1,1]
with(sub.Data, plot(sub.Data$Date, as.numeric(Global_active_power), type = "l",
          xlab = "", ylab = "Global Active Power"))

## [1,2]
with(sub.Data,plot(sub.Data$Date,as.numeric(Voltage),type = "l",
          xlab = "datetime",ylab = "Voltage"))

## [2,1]
with(sub.Data,plot(sub.Data$Date,as.numeric(Sub_metering_1),type = "l",
          xlab = "",ylab = "Energy sub metering"))
with(sub.Data, points(sub.Data$Date,as.numeric(Sub_metering_2),type = "l", col = "red"))
with(sub.Data,points(sub.Data$Date,as.numeric(Sub_metering_3),type = "l",col = "blue"))

legend("topright", col = c("black", "blue", "red"),
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1,bty="n")

## [2,2]
with(sub.Data,plot(sub.Data$Date, as.numeric(Global_reactive_power),type = "l",
          xlab = "datetime",ylab = "Global_reactive_power"))
##dev.copy(png,'plot4.png')
dev.off()