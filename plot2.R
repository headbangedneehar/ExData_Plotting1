library(data.table)
read.table("household_power_consumption.txt",sep = ";",header = TRUE)->proj1
as.data.table(proj1)->proj1
setkey(proj1,Date)
proj1[list(c(Date="1/2/2007",Date="2/2/2007")),]->twoDaysData
as.POSIXct(paste(twoDaysData$Date,twoDaysData$Time),
           format="%d/%m/%Y %H:%M:%S")->twoDaysTime
png(filename="plot2.png",width=480,height=480,units="px")
plot(twoDaysTime,as.numeric(as.character(twoDaysData$Global_active_power)),
     ylab="Global Active Power (kilowatts)",xlab="",type = "n")
lines(twoDaysTime,as.numeric(as.character(twoDaysData$Global_active_power)))
dev.off()



dates<-c(as.Date(lsd[[1]]$Date,"%d/%m/%Y"),as.Date(lsd[[2]]$Date,"%d/%m/%Y"))
times<-c(as.character(lsd[[1]]$Time),as.character(lsd[[2]]$Time))
as.POSIXct(paste(dates,times))->dt
plot(dt,as.numeric(as.character(twoDaysData$Global_active_power)))