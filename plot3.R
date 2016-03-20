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

## Plot of Global Active Power v. DateTime
plot(hpc$datetime[datetime_range], hpc$Sub_metering_1[datetime_range],
     col='black',
     main='',
     ylab='Energy sub metering',
     xlab='',
     type='l')

## Overlay sub_metering_2
points(hpc$datetime[datetime_range], hpc$Sub_metering_2[datetime_range],
       col='red',
       type='l')
       
## Overlay sub_metering_3
points(hpc$datetime[datetime_range], hpc$Sub_metering_3[datetime_range],
       col='blue',
       type='l')

legend(1, 95,
  legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
  col=c('black', 'red', 'blue'),
  lty=1,
  cex=0.7)
## Create a png copy of the plot.
dev.print(png, file = "plot3.png", width = 480, height = 480)