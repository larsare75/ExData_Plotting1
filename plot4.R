if (!file.exists("data.zip")) {
  download.file(url="http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip")
  unzip("data.zip")  
}  

#rough estimate of mem consumption: 2000000*9*8=144MB => see that rstudio uses 159 MB so seems good
elpowcons<-read.table(file="household_power_consumption.txt",header = FALSE, sep=";",skip=66637,nrows=2880,na.strings="?")
headpowcons<-read.table(file="household_power_consumption.txt", sep=";", nrows=1)

colnames(elpowcons)<-unlist(headpowcons)
elpowcons$Time<-paste(elpowcons$Date,elpowcons$Time)

elpowcons$Date=as.Date(elpowcons$Date,format = "%d/%m/%Y")
elpowcons$Time<- strptime(elpowcons$Time,format= "%d/%m/%Y %H:%M:%S")

png(filename="plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(elpowcons$Time,elpowcons$Global_active_power,type = "l", ylab = "Global Active Power",xlab="")
plot(elpowcons$Time,elpowcons$Voltage,type = "l", ylab = "Voltage",xlab="datetime")
plot(elpowcons$Time,elpowcons$Sub_metering_1,type = "l", ylab = "Energy sub metering",xlab="")
lines(elpowcons$Time,elpowcons$Sub_metering_2,col="red")
lines(elpowcons$Time,elpowcons$Sub_metering_3,col="blue")
legend("topright",lwd=1,lty=1,col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(elpowcons$Time,elpowcons$Global_reactive_power,type = "l",ylab="Global_reactive_power",xlab="datetime")
dev.off()