##Variables
fname ="plot13.png"
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
hist(data$Global_active_power, main="Global Active Power",  
    xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red") 
 
## Save file 
dev.copy(png, filename = fname, height=480, width=480) 
dev.off() 
