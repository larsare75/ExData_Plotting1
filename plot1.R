
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

hist(elpowcons$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

#default is 480X480
dev.copy(png,file="plot1.png")
dev.off()