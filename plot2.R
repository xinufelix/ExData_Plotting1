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
plot(hpc$datetime[datetime_range], hpc$Global_active_power[datetime_range],
     col='black',
     main='',
     ylab='Global Active Power (kilowatts)',
     xlab='',
     type='l')

## Create a png copy of the plot.
dev.print(png, file = "plot2.png", width = 480, height = 480)