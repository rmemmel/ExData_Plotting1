# 2020.08.25

# The GAP between the course materials and assignments is frustrating

# packages we need
        library(lubridate)

# read in the data
# written by rmemmel
# using the “Individual household electric power consumption Data Set”
        power_data<-read.table("household_power_consumption.txt",
                               header=T, sep=";")
        
# convert date and time to DATE class
        power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
        
#Filter to relevant dates (2880 obs)
        power_data<-subset(power_data, Date == "2007-02-01" | Date =="2007-02-02")

# Convert data to numeric
        power_data$Global_active_power <- as.numeric(power_data$Global_active_power)
        
# Size and name the chart
        png("plot1.png", width=480, height=480)
        
# Build the chart
        hist(power_data$Global_active_power,
             main="Global Active Power", 
             xlab="Global Active Power (kilowatts)", 
             ylab="Frequency", 
             col="Red")
        
# close the display     
        dev.off()
        
        