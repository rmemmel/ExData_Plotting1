# 2020.08.25
# written by rmemmel
# packages we need
        library(lubridate)

# read in the data, 
# using the “Individual household electric power consumption Data Set”
        power_data<-read.table("household_power_consumption.txt",
                       header=T, sep=";", na.strings="?")

# convert date and time to DATE class
        power_data$myDate <- as.Date(power_data$Date, format="%d/%m/%Y")

#Filter to relevant dates (2880 obs)
        mydata<-subset(power_data, myDate >= "2007-02-01" & myDate < "2007-02-03")

# create new col with concatenated date
        mydata$dateTime <- strptime(paste(mydata$Date, mydata$Time),"%d/%m/%Y %H:%M:%S")

# Convert data to numeric
        mydata$Global_active_power <- as.numeric(mydata$Global_active_power)

# Size and name the chart
        png("plot4.png", width=480, height=480)

#Set global parameters
        par(mfrow=c(2,2))

# Build the first chart
        with(mydata, plot(dateTime, Global_active_power, 
                          type="l", 
                          xlab="Day", 
                          ylab="Global Active Power"))

# Build the second chart
        with(mydata, plot(dateTime, Voltage, 
                          type = "l", 
                          xlab="datetime", 
                          ylab="Voltage"))

# Build the third chart
        with(mydata, plot(dateTime, Sub_metering_1, 
                  type="l", 
                  xlab="Day", 
                  ylab="Energy sub metering"))
        
#Add the sub metering lines
        lines(mydata$dateTime, mydata$Sub_metering_2,type="l", col= "red")
        lines(mydata$dateTime, mydata$Sub_metering_3,type="l", col= "blue")

#build the legend
        legend(c("topright"), 
                c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                lty= 1, lwd=2, bty="n", cex = .8,
                 col = c("black", "red", "blue"))

# Build the forth chart
        with(mydata, plot(dateTime, Global_reactive_power, 
                          type="l", 
                          xlab="datetime", 
                          ylab="Global_reactive_power"))
        
# close the display     
dev.off()