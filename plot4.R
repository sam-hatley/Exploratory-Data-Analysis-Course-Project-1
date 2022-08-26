clean_dat = function(){
  library(lubridate)
  library(dplyr)
  
  dat = read.table("./data/household_power_consumption.txt", sep = ";", header = T)
  
  dat$Date = paste(dat$Date,dat$Time,"UTC",sep = " ")
  dat$Date = dmy_hms(dat$Date)
  startdate = dmy_hms("01-02-2007 00:00:00 UTC")
  enddate = dmy_hms("02-02-2007 23:59:59 UTC")
  dat = dat[dat$Date >= startdate & dat$Date <= enddate,]
  
  for(i in 3:9){
    dat[,i] = as.numeric(dat[,i])
  }
  
  dat = subset(dat, select = -Time)
  
  colnames(dat) = c("Date","Global Active Power (kW)","Global Reactive Power (kW)",
                    "Voltage (v)","Global Intensity (Amps)","Energy Sub-metering No. 1 (Wh)",
                    "Energy Sub-metering No.2 (Wh)", "Energy Sub-metering No.3 (Wh)")
  
  return(dat)
}

plot4 = function(dat){
  png(file="./plot4.png",
      width = 480, height = 480)
  
  par(mfrow=c(2,2))
  
  plot(dat$Date,dat$`Global Active Power (kW)`,
       type = "l", main="",ylab = "Global Active Power (kW)", xlab="")
  
  plot(dat$Date,dat$`Voltage (v)`,
       type = "l", main="",ylab = "Global Active Power (kW)", xlab="Day")
  
  plot(dat$Date, dat$`Energy Sub-metering No. 1 (Wh)`,type = "l",
       xlab = "", ylab = "Energy sub metering")
  lines(dat$Date,dat$`Energy Sub-metering No.2 (Wh)`, col = "red")
  lines(dat$Date,dat$`Energy Sub-metering No.3 (Wh)`,col = "blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         lty = c(1,1,1), bty = "n", col = c("black","red","blue"))
  
  plot(dat$Date,dat$`Global Reactive Power (kW)`, type = "l",
       xlab = "Day",ylab = "Global Reactive Power (kW)")
  
  dev.off()
}

dat = clean_dat()
plot4(dat)