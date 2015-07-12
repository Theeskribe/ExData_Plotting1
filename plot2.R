# Script:  plot2.R
# Project: Exploratory Data Analysis - Course Project 1 - Plot 2
# Purpose: This R script utilizes data from UCI's Machine Learning repository 
# for household power consumption gathered between Dec 2006 and Nov 2010. 
# The R code generates an line chart graph showing the Global Active Power in
# Kilowatts over time for the dates of 2/1/2007 and 2/2/2007.
# The graph is written to a PNG file (plot2.png) as specified in the Course
# Project description. 

# define script constants
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile = "./exdata-data-household_power_consumption.zip"
datafile = "./household_power_consumption.txt"
pngfile = "./plot2.png"
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

# create line chart graph
with(powerdata, plot(datetime,Global_active_power, type="l",
                     xlab="", ylab="Global Active Power (kilowatts)" ))

# Turn off PNG device driver to flush graphical output to PNG file
dev.off()
