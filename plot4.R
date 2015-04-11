library(data.table)  #using data.table
read.table("household_power_consumption.txt",sep = ";",header = TRUE)->proj1 #load table in proj1
as.data.table(proj1)->proj1
setkey(proj1,Date)  #set Date as key
proj1[list(c(Date="1/2/2007",Date="2/2/2007")),]->twoDaysData  #segregate data for 2days
as.POSIXct(paste(twoDaysData$Date,twoDaysData$Time),
           format="%d/%m/%Y %H:%M:%S")->twoDaysTime  #concatenate date and time as POSIXct

png(filename = "plot4.png",width=480,height=480, type = "cairo-png")  #initialize png device

par(mfrow=c(2,2),bg="transparent")  #bd could have been white, I preffered transparent

#plot 1 followed by line plotting
plot(twoDaysTime,as.numeric(as.character(twoDaysData$Global_active_power)),
                       ylab="Global Active Power",xlab="",type="n")
lines(twoDaysTime,as.numeric(as.character(twoDaysData$Global_active_power)))

#plot2 followed by line plotting
plot(twoDaysTime,as.numeric(as.character(twoDaysData$Voltage)),
     ylab="Voltage",xlab="datetime",type="n")
lines(twoDaysTime,as.numeric(as.character(twoDaysData$Voltage)))

#plot3 followed by lines plotting and legend
with(proj1,
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_1)),type="n",
          xlab="",ylab="Energy sub metering"),
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_2)),type="n"),
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_3)),type="n"))
legend(legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       x = "topright",horiz = F,lwd = 2,col= c("black","red","blue"),bty="n",cex=0.9)
lines(proj1,lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_1)),col="black"),
      lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_2)),col="red"),
      lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_3)),col="blue"))

#plot4 followed by lines plotting
plot(twoDaysTime,as.numeric(as.character(twoDaysData$Global_reactive_power)),
           ylab="Global_reactive_power",xlab="datetime",type="n")
lines(twoDaysTime,as.numeric(as.character(twoDaysData$Global_reactive_power)),lwd=0.9)    

#turn png device off
dev.off()

#see plo4.png file created
file.show("plot4.png")



