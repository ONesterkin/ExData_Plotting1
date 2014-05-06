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
png("plot3.png")

#plotting datetime as X axis vs sub metering 1 as Y axis
#type="l" for line instead of dots
#xlab and ylab for axis labels
plot(cons$datetime,
     cons$sub_metering_1,
     type="l",
     col="black",
     ylab="Energy sub metering",
     xlab="")
#adding sub metering 2 & 3
points(cons$datetime, cons$sub_metering_2, type="l", col="red")
points(cons$datetime, cons$sub_metering_3, type="l", col="blue")

#adding legend
#lty for drawing lines as markers
legend("topright",
       lty="solid",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#turning off graph device
dev.off()