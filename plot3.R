library(data.table)  #using data.table
read.table("household_power_consumption.txt",sep = ";",header = TRUE)->proj1 #load table in proj1
as.data.table(proj1)->proj1
setkey(proj1,Date)  #set Date as key
proj1[list(c(Date="1/2/2007",Date="2/2/2007")),]->twoDaysData  #segregate data for 2days
as.POSIXct(paste(twoDaysData$Date,twoDaysData$Time),
           format="%d/%m/%Y %H:%M:%S")->twoDaysTime  #concatenate date and time as POSIXct

png(filename = "plot3.png",width=480,height=480) #initialize png device
#initialize transparent background
par(bg="transparent")
#create plot and draw nothing
with(proj1,
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_1)),type="n",
          xlab="",ylab="Energy sub metering"),
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_2)),type="n"),
     plot(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_3)),type="n"))

#draw legend
legend(legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),x = "topright",horiz = F,lty=1,lwd = 2,col= c("black","red","blue"))

#draw lines
lines(proj1,lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_1)),col="black"),
      lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_2)),col="red"),
      lines(twoDaysTime,as.numeric(as.character(twoDaysData$Sub_metering_3)),col="blue"))

#turn off png device
dev.off()
#show created file
file.show("plot3.png")