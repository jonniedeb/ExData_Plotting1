#Read in decompressed data
#Load data table library
library(data.table)
#Set column classes
colClasses<-c("character", "character", "numeric", "numeric", "numeric", 
              "numeric", "numeric", "numeric", "numeric")
#Assign data to data variable
data<-fread(input = "data/household_power_consumption.txt",
            sep = ";", header=TRUE,na.strings = "?",colClasses = colClasses)
#Convert date
data$Date<-as.Date(data$Date,format = "%d/%m/%Y")

#subset to specific dates
data<-data[data$Date>="2007-02-01"  & data$Date <="2007-02-02"]

#Convert to data frame and create a variable combining date and time
data<-as.data.frame(data)
data$DT<-paste(data$Date,data$Time)
data$DT<-strptime(data$DT,format = "%Y-%m-%d %H:%M:%S")


#Make plot4
par(mar=c(4,4,2,2), mfrow=c(2,2), cex=0.65, bg=NA)
    #subplot1
    with(data, plot(DT, Global_active_power,xlab="",ylab="Global Active Power", type="n"))
    with(data,lines(DT, Global_active_power))
    #subplot2
    with(data, plot(DT, Voltage, xlab="datetime",ylab="Voltage", type="n"))
    with(data,lines(DT, Voltage))
    #subplot3
    with(data, plot(DT, Sub_metering_1,xlab="",ylab="Energy sub metering", type="n"))
    with(data,lines(DT, Sub_metering_1), col="black")
    with(data,lines(DT, Sub_metering_2, col="red"))
    with(data,lines(DT, Sub_metering_3, col="blue"))
    legend("topright", bty="n", lwd=1, cex=0.8, y.intersp=0.5,x.intersp=0.5, text.width = strwidth("Sub_metering"),col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
    #subplot4
    with(data, plot(DT, Global_reactive_power,xlab="datetime", type="n"))
    with(data,lines(DT, Global_reactive_power))
    
#export to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480, units= "px")
dev.off() 

