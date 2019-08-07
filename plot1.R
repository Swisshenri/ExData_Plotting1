###   P L O T   1



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

dat$Date<- as.Date(dat$Date, "%d/%m/%Y")

## Then FILTER BY 2007-02-01 and 2007-02-02.

fdat <- subset(dat,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## fdat <- dat[dat$Date %in% c("1/2/2007","2/2/2007"),]  ## could also be without converting to date but not clean


## To make sure we use complete cases we could use
##    use function: fdat <- fdat[complete.cases(fdat),]

## now we have an fdat working file to do the rest of 

## 3)  DO THE   P L O T    1  Histogram


hist(fdat$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save PLot 1 to a png.file 
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()



