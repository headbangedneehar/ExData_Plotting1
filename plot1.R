library(data.table)
read.table("household_power_consumption.txt",sep = ";",header = TRUE)->proj1
as.data.table(proj1)->proj1
setkey(proj1,Date)
proj1[list(c(Date="1/2/2007",Date="2/2/2007")),]->twoDaysData
png(filename = "plot1.png",width=480,height=480,units="px")
hist(as.numeric(as.character(twoDaysData$Global_active_power)),
     main = "Global Active Power",
     xlab="Global Active Power (kilowatts)",col = "red")
dev.off()
