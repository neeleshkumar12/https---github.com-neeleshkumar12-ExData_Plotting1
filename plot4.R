##Variables
fname ="plot4.png"
startdate = "2007-02-01"
enddate = "2007-02-02"
numberofrows =  2075259


## Reading data 
data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",  
                      nrows = numberofrows, check.names=F, stringsAsFactors=F, comment.char="", quote='\"') 
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y") 

 
## Getting the required data
data <- subset(data_full, subset=(Date >= startdate & Date <= enddate)) 
rm(data_full) 

datetime <- paste(as.Date(data$Date), data$Time) 
data$Datetime <- as.POSIXct(datetime) 

## Plotting 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) 
with(data, { 
   plot(Global_active_power~Datetime, type="l",  
        ylab="Global Active Power (kilowatts)", xlab="") 
   plot(Voltage~Datetime, type="l",  
        ylab="Voltage (volt)", xlab="") 
   plot(Sub_metering_1~Datetime, type="l",  
        ylab="Global Active Power (kilowatts)", xlab="") 
   lines(Sub_metering_2~Datetime,col='Red') 
   lines(Sub_metering_3~Datetime,col='Blue') 
   legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
          legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
   plot(Global_reactive_power~Datetime, type="l",  
        ylab="Global Rective Power (kilowatts)",xlab="") 
}) 
 
## Save file 
dev.copy(png, filename=fname, height=480, width=480) 
dev.off() 