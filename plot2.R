library(data.table)  #using data.table
read.table("household_power_consumption.txt",sep = ";",header = TRUE)->proj1 #load table in proj1
as.data.table(proj1)->proj1
setkey(proj1,Date)  #set Date as key
proj1[list(c(Date="1/2/2007",Date="2/2/2007")),]->twoDaysData  #segregate data for 2days
as.POSIXct(paste(twoDaysData$Date,twoDaysData$Time),
           format="%d/%m/%Y %H:%M:%S")->twoDaysTime  #concatenate date and time as POSIXct

png(filename="plot2.png",width=480,height=480)  #initialize ng device
#initialize transparent background
par(bg="transparent")
#create plot and draw nothing
plot(twoDaysTime,as.numeric(as.character(twoDaysData$Global_active_power)),
     ylab="Global Active Power (kilowatts)",xlab="",type = "n")
#draw lines
lines(twoDaysTime,as.numeric(as.character(twoDaysData$Global_active_power)))
#turn off png devie
dev.off()
#see create plot2 file
file.show("plot2.png")