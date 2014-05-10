
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

# Setting the global parameters before printing the plot
par(mfrow=c(1,1), mar=c(2,4,2,2))

# Open the png file device with the appropriate file name
png(filename="plot3.png")

# printing the "Sub_metering_1" first along with fixing the x and y labels 
with(subsetData, plot(datetime, Sub_metering_1, type="s", ylab="Energy sub metering", xlab=""))

# adding points corresponding to "Sub_metering_2" with color red
with(subsetData, points(datetime, Sub_metering_2, col="red", type="s"))

# adding points corresponding to "Sub_metering_3" with color blue
with(subsetData, points(datetime, Sub_metering_3, col="blue", type="s"))

# creating the legend at the top right
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), pch=95, pt.cex=2)

# closing the file device
dev.off()