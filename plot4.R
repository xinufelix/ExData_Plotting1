## What is the line number of 2007-02-01 00:00:00?
start_datetime <- grep("^1/2/2007", readLines('data/household_power_consumption.txt')) - 1

## Adjust for presence of the header
start_datetime <- start_datetime - 1

## Number of minutes in two days
two_days_min <- 2*24*60

## Start read from 2007-02-01 00:00:00 and include 2 days of observations.
hpc <- read.csv("data/household_power_consumption.txt",
                header = TRUE,
                skip=start_datetime,
                nrow=two_days_min,
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

## Add the column names which were skipped during the file read.
names(hpc) <- c('Date', 
                'Time', 
                'Global_active_power', 
                'Global_reactive_power',
                'Voltage', 
                'Global_intensity', 
                'Sub_metering_1', 
                'Sub_metering_2', 
                'Sub_metering_3')

## Combine Date, Time columns into a datetime object.
hpc$datetime <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")

## Create 2x2 panel of plots
par(mfrow = c(2,2))

## Plot of Global Active Power v. DateTime
plot(hpc$datetime, hpc$Global_active_power,
     col='black',
     main='',
     ylab='Global Active Power',
     xlab='',
     type='l')

## Panel 2: Voltage v. datetime
plot(hpc$datetime, hpc$Voltage,
     col='black',
     main='',
     ylab='Voltage',
     xlab='datetime',
     type='l')

## Plot of Global Active Power v. DateTime
plot(hpc$datetime, hpc$Sub_metering_1,
     col='black',
     main='',
     ylab='Energy sub metering',
     xlab='',
     type='l')

## Overlay sub_metering_2
lines(hpc$datetime, hpc$Sub_metering_2,
       col='red')

## Overlay sub_metering_3
lines(hpc$datetime, hpc$Sub_metering_3,
       col='blue')

## Customize the text width to prevent truncation.
legend("topright",
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'),
       lty=1,
       text.width=2.05*strwidth("Sub_metering_1"))

## Plot Global Reactive Power v. DateTime
plot(hpc$datetime, hpc$Global_reactive_power,
     col='black',
     main='',
     ylab='Global_reactive_power',
     xlab='datetime',
     type='l')

## Create a png copy of the plot.
dev.print(png, file = "plot4.png", width = 480, height = 480)