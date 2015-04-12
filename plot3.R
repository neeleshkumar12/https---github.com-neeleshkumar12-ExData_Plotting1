##Variables
fname ="plot3.png"
startdate = "2007-02-01"
enddate = "2007-02-02"
numberofrows =  2075259



## Reading data 
data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",  
                      nrows = numberofrows, check.names=F, stringsAsFactors=F, comment.char="", quote='\"') 
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y") 

 
## Getting the required data 
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02")) 
rm(data_full) 

datetime <- paste(as.Date(data$Date), data$Time) 
data$Datetime <- as.POSIXct(datetime) 

## Plotting 
with(data, { 
   plot(Sub_metering_1~Datetime, type="l", 
        ylab="Global Active Power (kilowatts)", xlab="") 
   lines(Sub_metering_2~Datetime,col='Red') 
   lines(Sub_metering_3~Datetime,col='Blue') 
}) 
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,  
      legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

## Save file 
dev.copy(png, filename = fname, height=480, width=480) 
dev.off() 
