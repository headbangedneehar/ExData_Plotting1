library(data.table)  #using data.table
read.table("household_power_consumption.txt",sep = ";",header = TRUE)->proj1  #load table in proj1
as.data.table(proj1)->proj1
setkey(proj1,Date)  #set Date as key
proj1[list(c(Date="1/2/2007",Date="2/2/2007")),]->twoDaysData  #load data required for 2days
png(filename = "plot1.png",width=480,height=480)  #initialize png device
par(bg="transparent")   #initialize transparent background
hist(as.numeric(as.character(twoDaysData$Global_active_power)),
     main = "Global Active Power",
     xlab="Global Active Power (kilowatts)",col = "red") #draw histogram
dev.off()  #turn off png device
file.show("plot1.png")
