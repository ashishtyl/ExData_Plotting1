library(dplyr)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("data.zip")){
  download.file(url,"data.zip")
}

if(!file.exists("household_power_consumption.txt")){
  unzip("data.zip","household_power_consumption.txt")
}

data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";")

data$timestamp<- as.POSIXct(strptime(paste(data$Date," ",data$Time),"%d/%m/%Y %H:%M:%S"))

filtered <- filter(data,timestamp>='2007-02-01',timestamp<'2007-02-03')

for (i in 3:9){
  filtered[,i]<-as.numeric(as.character(filtered[,i]))
}

png(filename="Plot1.png",width=480,height = 480)
hist(filtered$Global_active_power,
     main = "Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab =  "Frequency",
     col = "red"
     )
dev.off()

