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

plot1 = function(dat){
  png(file="./plot1.png",
      width = 480, height = 480)
  
  hist(dat$`Global Active Power (kW)`, main = "Global Active Power", 
       col = "red", xlab = "Global Active Power (kW)", ylab = "Frequency")
  
  dev.off()
}

dat = clean_dat()
plot1(dat)