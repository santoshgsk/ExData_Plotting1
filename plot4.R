
# Reading only the subset data for Feb 1st, Feb 2nd of 2007
subsetData <- read.csv("household_power_consumption.txt", sep=";", skip=66637, nrow=2880, na.strings=c("?"), colClasses=c(rep("character",2), rep("numeric", 7)))

# To associate the column names, reading the header line into a temporary data frame
forColNames <- read.csv("household_power_consumption.txt", sep=";", header=T, nrow=1)

# Assigning the actual column names to the subset data
colnames(subsetData) <- colnames(forColNames)

# Pasting the date and time and reading them as Date structures
dateTime <- strptime(paste(subsetData[,1], subsetData[,2]), format="%d/%m/%Y %H:%M:%S")

# Appending the Date structures read into an additional column named "datatime"
subsetData$datetime <- dateTime

# Open the png file device with the appropriate file name
png(filename="plot4.png")

# Setting the global parameters before printing the plot
par(mfrow=c(2,2), mar=c(4, 4, 4, 2))

# Printing plot with datetime vs Global active power at (1,1) position
with(subsetData, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

# Printing plot with datetime vs Voltage at (1,2) position
with(subsetData, plot(datetime, Voltage, type="s"))

# Printing plot with datetime vs various Sub_metering differentiated with color at (2,1) position
with(subsetData, plot(datetime, Sub_metering_1, type="s", ylab="Energy sub metering", xlab=""))
with(subsetData, points(datetime, Sub_metering_2, col="red", type="s"))
with(subsetData, points(datetime, Sub_metering_3, col="blue", type="s"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", col=c("black", "red", "blue"), pch=95, pt.cex=2)

# Printing plot with datetime vs Global reactive power at (2,2) position
with(subsetData, plot(datetime, Global_reactive_power, type="s"))

# closing the file device
dev.off()