# Coursera Data Science Specialization
# Exploratory Data Analysis course project
#
# Newton Ramos Garcia (newxhost@gmail.com)

library(data.table)

# Set language to english
Sys.setlocale("LC_TIME", "C")

# Set working directory
setwd(".")
path <- getwd()

# Download dataset file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

dataset_filename <- "household_power_consumption.zip"

# Downloads dataset file unless it already exists
if(!file.exists(file.path(path, dataset_filename))) {
  download.file(url, file.path(path, dataset_filename))
}

# Unzip dataset file
unzip(zipfile = dataset_filename)

# Reads data file
dt_hpc <- read.table(file.path("household_power_consumption.txt"),
                     sep = ";",
                     na.strings = "?",
                     header = TRUE)

# Reads only a subset of data between 2007-02-01 and 2007-02-02
dt_hpc_subset <- subset(dt_hpc, Date == "1/2/2007" | Date == "2/2/2007")

# Merge `Date` and `Time` variables into a single column
dt_hpc_subset$datetime <- with(dt_hpc_subset, strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

# Open a PNG device and create a "plot1.png" image file
png(file = "plot3.png")

# Creates a line plot
plot(dt_hpc_subset$datetime, dt_hpc_subset$Sub_metering_1,
     type = "l",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")

lines(dt_hpc_subset$datetime, dt_hpc_subset$Sub_metering_2, type = "l", col = "red")
lines(dt_hpc_subset$datetime, dt_hpc_subset$Sub_metering_3, type = "l", col = "blue")

legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty = 1
     )


# Close PNG file device
dev.off()
