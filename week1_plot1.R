library(data.table)
## Read data
data <- fread("household_power_consumption.txt");

## replace the missing values as NA
data[data == "?"] <- NA
## Create date and subset relevant date range
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
sub.Data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]
# # Converting the rest
# DT$posix <- paste(DT$Date, DT$Time, sep = " ")
# DT$posix <- strptime(DT$fulldate, format = "%d/%m/%Y %H:%M:%S")


## Create graph and save in png format

hist(as.numeric(sub.Data$Global_active_power),
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png,'plot1.png')
dev.off()