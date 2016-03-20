## Data are located under the 'data' subdirectory which is included with the repository.
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

## Combine Date, Time columns into a datetime object.
hpc$datetime <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")

## The plot starts on a Thursday, so get all of them and use the first one. 
thursdays <- which(weekdays(hpc$datetime) == 'Thursday')

## The range of interest is 48 hours which includes 2880 observations.
two_days_min <- 2*24*60

## Subset observations staring the first Thursday from the dataset as the starting point.
datetime_range <- thursdays[1]:(thursdays[1]+two_days_min)

## Create 2x2 panel of plots
par(mfrow = c(2,2))

## Plot of Global Active Power v. DateTime
plot(hpc$datetime[datetime_range], hpc$Global_active_power[datetime_range],
     col='black',
     main='',
     ylab='Global Active Power',
     xlab='',
     type='l')

## Panel 2: Voltage v. datetime
plot(hpc$datetime[datetime_range], hpc$Voltage[datetime_range],
     col='black',
     main='',
     ylab='Voltage',
     xlab='datetime',
     type='l')

## Plot of Global Active Power v. DateTime
plot(hpc$datetime[datetime_range], hpc$Sub_metering_1[datetime_range],
     col='black',
     main='',
     ylab='Energy sub metering',
     xlab='',
     type='l')

## Overlay sub_metering_2
lines(hpc$datetime[datetime_range], hpc$Sub_metering_2[datetime_range],
       col='red')

## Overlay sub_metering_3
lines(hpc$datetime[datetime_range], hpc$Sub_metering_3[datetime_range],
       col='blue')

## Customize the text width to prevent truncation.
legend("topright",
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'),
       lty=1,
       text.width=1.8*strwidth("Sub_metering_1"))

plot(hpc$datetime[datetime_range], hpc$Global_reactive_power[datetime_range],
     col='black',
     main='',
     ylab='Global_reactive_power',
     xlab='datetime',
     type='l')


## Create a png copy of the plot.
dev.print(png, file = "plot4.png", width = 480, height = 480)