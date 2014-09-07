
## Exploratory Data Analysis  - Project 1 - Plot FOUR (4)
##----------------------------------------
## Description: Measurements of electric power 
## consumption in one household with a 
## one-minute sampling rate over a 
## period of almost 4 years using the 
## "Individual household electric power consumption Data Set"

## Downloading, unzipping & Preparing data
## Download and Unzip  the files

{ temp <- tempfile()                      ## download zipped data into temp file.
  
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)                                                          ## unzip the file. Keep zip directory
  unlink(file, recursive = FALSE)     ## unlink the unzipped file
}

##  File unzipped
## rename file to power; Individual household power consumption Data
power <- read.table(file, header=T, sep=";" )
## convert the Date and Time variables to Date/Time classes using as.Date() function
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
## df is data frame containing the data for the two days of Feb 2007 in review
## remove the missing (?) values
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
## convert columns 3:9 to numeric by applying two step process
##  as.character() and then as.numeric()
## remove '?' (unknown) values
?.omit(df)
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
plot4 <- function() {
                                          par(mfrow=c(2,2))
                                          
                                          ##PLOT 1
                                          plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
                                          ##PLOT 2
                                          plot(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
                                          
                                          ##PLOT 3
                                          plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
                                          lines(df$timestamp,df$Sub_metering_2,col="red")
                                          lines(df$timestamp,df$Sub_metering_3,col="blue")
                                          legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
                                          
                                          #PLOT 4
                                          plot(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
                                          
                                          #OUTPUT
                                          dev.copy(png, file="plot4.png", width=480, height=480)
                                          dev.off()
                                          cat("plot4.png has been saved in", getwd())
}
plot4()
