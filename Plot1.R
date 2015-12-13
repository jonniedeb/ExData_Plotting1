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
    
    #Convert to data frame and convert time
    data<-as.data.frame(data)
    data$DT<-paste(data$Date,data$Time)
    data$DT<-strptime(data$DT,format = "%Y-%m-%d %H:%M:%S")
    
#Make plot1
par(mar=c(5,5,3,3), bg=NA)
with(data, hist(Global_active_power, col=rgb(1,37/255,0),
     xlab = "Global Active Power (kilowatts)",ylab = "Frequency", 
     main="Global Active Power"))
    
#export to PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480, units= "px")
dev.off() 
    
    