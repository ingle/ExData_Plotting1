if (!file.exists('exdata_data_household_power_consumption.zip')) {
    print('data not found. downloading...')
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip')
    unzip('exdata_data_household_power_consumption.zip')
    print('done.');
}
# do a dummy read from the top to get header names
headers <- read.table('household_power_consumption.txt', 
                    sep=';', header=TRUE, nrows=3) 
res <- grep("^[1-2]/2/2007", readLines('household_power_consumption.txt'));
# now read actual data, skipping rows from the top to avoid reading
# entire text file
data <- read.table( unz('exdata_data_household_power_consumption.zip', 
                        'household_power_consumption.txt'), 
                    sep=';', header=FALSE,
                    skip=res[1]-1, nrows=length(res))
# set headers for data from our ``dummy read''
dimnames(data)[[2]] <- dimnames(headers)[[2]]

png('plot3.png')
plot( strptime(paste(data$Date,data$Time), format='%d/%m/%Y %H:%M:%S'), 
     data$Sub_metering_1, type='s', col='black', xlab='', ylab='Energy sub metering')
par(new=T)
plot( data$Sub_metering_2, type='s', col='red' , axes=F, xlab='', ylab='', ylim=c(0,30))
par(new=T)
plot( data$Sub_metering_3, type='s', col='blue', axes=F, xlab='', ylab='', ylim=c(0,30))
legend('topright',col=c('black', 'red', 'blue'), 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1,1,1), seg.len=3)
dev.off()



