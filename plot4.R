
## P L O T    4
## Are 4 plots:  Plot 2 and plot 3 (previous) and 2 new ones
## Here we have to use a 2 x 2 par(), use 2 previous plots and 2 new ones 
## use par(mfcol = c(2, 2) instead of mfrow to get it into the same order





## DO THE   P L O T    4.2 (repeat PLOT 3 in this project)

## load the labels for one of the plots before
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(fdat,      
    {
      ## 4.1 plot
      plot(fdat$Global_active_power~fdat$comb_dateTime, type="l", ylab="Global Active Power", xlab="")
      
      ## 4.2 plot
      plot(Sub_metering_1~comb_dateTime, type="l",
           ylab="Global Active Power", xlab="")
       lines(Sub_metering_2~comb_dateTime,col='Red')
       lines(Sub_metering_3~comb_dateTime,col='Blue')
       legend("topright", legend=labels, col=columnlines, lty=1)
      
      ## 4.3 plot
      plot(Voltage~comb_dateTime, type="l", ylab="Voltage", xlab="datetime")
    
      ## 4.4 plot   
      plot(Global_reactive_power~comb_dateTime, type="l",
           ylab="Global_reactive_power", xlab="datetime")
     } 
     
)


dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

## reset the par() again to 1,1
par(mfrow=c(1,1))
