##   P L O T   3



## 1) FIRST STEP GET DATA 
## 
## First download the file to a directory within my computer 
## I tell R_studio to set working directory to that dir
## Then I create working data tables to work with the data for each file 
## 
## the character "~" is my root directory by default

setwd("~/Documents/JOHN HOPKINS UNIV/MONTH 04 ExploDataAnal /Assignmt_Mo04_Wk01")


## Read files into working tables with same names:

## I tried reading it this way: > dat <- read.table("household_power_consumption.txt")
##  but got 2075254 record and just (one) 1 variable lots of semicolons thus sep=";" 
## Then did this > dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
## Now got 9 variables and the headers but best is next where  variables are as numeric 
##  or character and na´s are filled with a ?
##  could also be read (filtered): >filteredfile <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)


## Could also read only the specific dates (filtered file) by using grep command directly
## filteredfile <- read.table(text = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value = TRUE), 
##   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
##      "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
##           sep = ";", header = TRUE)

dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                  colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


## 2) SECOND FILTER THE DATA 

## Filter dat for specific dates 2007-02-01 and 2007-02-02.

## First convert to date ( check date by looking at eg. dat$Date[995] it tells [1] 17/12/2006, thus day month year)

## This time I am going to convert it differntly 

### ie not use this function as in PLOT 1: (**1 before) dat$Date<- as.Date(dat$Date, "%d/%m/%Y")

## Then FILTER BY 2007-02-01 and 2007-02-02.

## (**2 before) fdat <- subset(dat,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))


## filter data just as it, is namely character


fdat <- dat[dat$Date %in% c("1/2/2007","2/2/2007"),]  


## then combine the two strings $Date + $ Time into one, (first rearrange DATE Format in Y-M-d order)
##  and finish off by conveting the combined string into Date as.POSIXct funct

fdat$Date<- as.Date(fdat$Date, "%d/%m/%Y")

comb_dateTime <- paste(fdat$Date, fdat$Time)

comb_dateTime <- as.POSIXct(comb_dateTime)


## get the column of combined date and time into the table

fdat <- cbind(comb_dateTime, fdat)


## 3)  DO THE   P L O T    3

## has to be done in R environment directly / R studio will create too big labels


## it is a plot repeating y axis 3 times Sub_metering_1, 2 and 3
## as y axis Global Active Power
## as x axis the 
## first time around x axis label must be blank xlab=""


with(fdat, 
          {plot(Sub_metering_1~comb_dateTime, type="l",
            ylab="Global Active Power (kilowatts)", xlab="")
            lines(Sub_metering_2~comb_dateTime,col='Red')
            lines(Sub_metering_3~comb_dateTime,col='Blue')
          }        
     )

## add labels and colors extra

columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend=labels, col=columnlines, lty=1)


dev.copy(png,"plot3.png", width=480, height=480)
dev.off()


