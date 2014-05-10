
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
png(filename="plot2.png")

# plotting the Plot No. 2 as illustrated in the Course Project Instructions
# The realtion is between datatime and Global active power
plot(subsetData$datetime, subsetData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# closing the file device
dev.off()