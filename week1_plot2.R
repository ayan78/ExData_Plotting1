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

plot(sub.Data$Date, as.numeric(sub.Data$Global_active_power), 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "Days")
dev.copy(png,'plot2.png')
dev.off()