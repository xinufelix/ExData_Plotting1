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


