#Reading data:
#only 2880 rows a read (2 days x 24 hours x 60 mins)
#starting point definde by looking at row data
#all other parameters are pretty straighforward, except that date isn't converted yet
cons <- read.table("household_power_consumption.txt", 
                   header=TRUE, 
                   sep=";", 
                   skip=66636, 
                   nrows=2880, 
                   na.strings = "?", 
                   colClasses = c(rep("character",2),
                                  rep("numeric",7)), 
                   col.names=c("date",
                               "time",
                               "global_active_power",
                               "global_reactive_power",
                               "voltage", 
                               "global_intensity", 
                               "sub_metering_1", 
                               "sub_metering_2", 
                               "sub_metering_3"))

#making datetime column in dataframe for correct conversion
cons <- data.frame(datetime = paste(cons$date, cons$time), cons)
#converting datetime from string to POXIXlt data
cons$datetime <- strptime(cons$datetime, format="%d/%m/%Y %H:%M:%S")
#removing old date and time columns
cons <- data.frame(cons[1], cons[4:10])

#opening device for plotting. default size is 480x480 so no parameters for it
png("plot2.png")

#plotting datetime as X axis vs global active power as Y axis
#type="l" for line instead of dots
#xlab and ylab for axis labels
plot(cons$datetime, 
     cons$global_active_power, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")
#turning off graph device
dev.off()