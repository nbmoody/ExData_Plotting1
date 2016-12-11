# Script for creating plot1.png,
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

data$date <- as.Date(data$date, "%d/%m/%Y") # Convert the date and time variables into Date and POSIXlt types.
data$time <- strptime(data$time, "%H:%M:%S")
data$time <- format(data$time, "%H:%M:%S")


# Subset the data as desired.
data <- subset(data, data$date >= "2007-02-01")
data <- subset(data, data$date <= "2007-02-02")


# Create the plot.
png(filename = "plot1.png", width = 480, height = 480)
with(data, hist(global_active_power, col="red",
                main="Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)"))
dev.off()



