# Script:  plot3.R
# Project: Exploratory Data Analysis - Course Project 1 - Plot 3
# Purpose: This R script utilizes data from UCI's Machine Learning repository 
# for household power consumption gathered between Dec 2006 and Nov 2010. 
# The R code generates a line chart graph showing the 3 Energy Sub Metering
# variables in Kilowatts over time for the dates of 2/1/2007 and 2/2/2007.
# The graph is written to a PNG file (plot3.png) as specified in the Course
# Project description. 

# define script constants
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile = "./exdata-data-household_power_consumption.zip"
datafile = "./household_power_consumption.txt"
pngfile = "./plot3.png"
pngwidth = 480
pngheight = 480

# load required libraries
library(graphics)

# download power consumption data set from UCI Machine Learning Repository site
download.file(url,zipfile,mode="wb")

# unzip power consumption data from data set zip file
unzip(zipfile = zipfile, overwrite = TRUE)

# load data set from data file
powerall <- read.table(datafile, header = TRUE, sep = ";",na.strings = "?",
                       ,stringsAsFactors = FALSE)

# create POSIXt datetime field for graphing data over time
powerall$datetime <- strptime(paste(as.Date(powerall$Date, format = "%d/%m/%Y"),
                                    powerall$Time),"%Y-%m-%d %H:%M:%S")

# filter data to only 2/1/2007 through 2/2/2007 (raw data in "d/m/yyyy" format)
powerdata <- subset(powerall,Date=="1/2/2007"|Date=="2/2/2007")

# Start PNG device driver to save graph output to PNG file
png(filename=pngfile, height=pngheight, width=pngwidth)

# create base linechart graph with Sub_metering_1 line
with(powerdata, plot(datetime, Sub_metering_1, type="l",
                     xlab="", ylab="Energy sub metering" ))

# add Sub_metering_2 line to linechart graph
with(powerdata, lines(datetime, Sub_metering_2,type="l", col="red"))

# add Sub_metering_3 line to linechart graph
with(powerdata, lines(datetime, Sub_metering_3,type="l", col="blue"))

# add the legend for the 3 Sub metering variables to linechart graph
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=1)

# Turn off PNG device driver to flush graphical output to PNG file
dev.off()
