library(data.table)
read.table("household_power_consumption.txt",sep = ";",header = TRUE)->proj1
as.data.table(proj1)->proj1
setkey(proj1,Date)
proj1[list(c(Date="1/2/2007",Date="2/2/2007")),]->twoDaysData
as.POSIXct(paste(twoDaysData$Date,twoDaysData$Time),
           format="%d/%m/%Y %H:%M:%S")->twoDaysTime
png(filename = "plot3.png",width=480,height=480,units="px")

with(proj1,
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_1)),type="n",
          xlab="",ylab="Energy sub metering"),
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_2)),type="n"),
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_3)),type="n"))

legend(legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),x = "topright",horiz = F,lty=1,lwd = 2,col= c("black","red","blue"))

lines(proj1,lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_1)),col="black"),
      lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_2)),col="red"),
      lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_3)),col="blue"))

dev.off()
