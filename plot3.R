# Script for creating plot3.png,
# submitted in fulfillment of Exploratory Data Analysis, week 1.
# Nathaniel B. Moody, 09 December 2016


library(utils)


# Download the data into a unique repository, unzip it, and read it into R, then tidy it up.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./EDAplots/UCIdata.zip")) {
    dir.create("./EDAplots")
    download.file(url, destfile = "./EDAplots/UCIdata.zip")
    unzip(zipfile = "./EDAplots/UCIdata.zip", exdir = "./EDAplots")
}

list <- ls() # These next few statements prevent re-reading the dataset back in every time you run the script.
if(!is.element("data", list)) {
    datanames <- c("date", "time", "global_active_power", "global_reactive_power", "voltage",
                   "global_intensity", "submetering1", "submetering2", "submetering3")
    data <- read.table("./EDAplots/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?",
                       stringsAsFactors = FALSE, col.names = datanames)
}

data$date_time <- paste(data$date, data$time)
data$date_time <- strptime(data$date_time, format = "%d/%m/%Y %H:%M:%S")
data$date <- as.Date(data$date, format = "%m/%d/%Y")

# Subset the data as desired.
data <- subset(data, data$date_time >= "2007-02-01 00:00:00")
data <- subset(data, data$date_time <= "2007-02-02 12:59:59")


# Create the plot.
png(filename = "plot3.png", width = 480, height = 480)
with(data, plot(date_time, submetering1, xlab = " ", ylab = "Energy sub metering", type="l"))
lines(data$date_time, data$submetering2, col="red")
lines(data$date_time, data$submetering3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
dev.off()


