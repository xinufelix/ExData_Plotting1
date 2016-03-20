## download the data file if it is not present 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
ptm <- proc.time()
hpc <- read.csv("~/coursera/eda/ExData_Plotting1/data/household_power_consumption.txt",
                                        sep=";", 
                                        colClasses = c('character',
                                                     'character',
                                                     'numeric',
                                                     'numeric',
                                                     'numeric',
                                                     'numeric',
                                                     'numeric',
                                                     'numeric',
                                                     'numeric'),
                                        na.strings="?",
                                        stringsAsFactors=FALSE)
print(proc.time() - ptm)

## Combine Date, Time columns into datetime
hpc$datetime <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")

## The plot starts on Thursday at 00:00:00 - assume local timezone.
thursdays <- which(weekdays(hpc$datetime) == 'Thursday')

## The range of the plot is two days at 1-minute intervals.
two_days_min<- 60*24*2

## Use the first Thursday from the dataset as the starting point.
hist(hpc$Global_active_power[thursdays[100]:(thursdays[100]+two_days_min)],
     col='red',
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)')

## Create a png copy of the plot.
dev.print(png, file = "plot1.png", width = 480, height = 480)
