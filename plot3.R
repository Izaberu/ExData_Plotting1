
library(dplyr)
library(lubridate)


# set working directory
setwd("C:/Users/me/Dropbox/Rprogramming/course4/week1/programmingassignment")

# download data
file_path_data <- "./household_power_consumption.txt" 
mydata <- read.table(file_path_data, header = TRUE, sep=";")


# Create tbl so we can work with dplyr
mydf <- tbl_df(mydata)

# Prepare data for the plot
thisdf <- mydf %>% 
    # subset the data from 2007-02-01 and 2007-02-02
    filter(dmy(Date) %in% c(ymd("2007-02-01"), ymd("2007-02-02"))) %>%
    # remove missing values that are coded as "?" in this data set
    filter(Sub_metering_1 != "?", Sub_metering_2 != "?", Sub_metering_3 != "?") %>%
    # change to numeric values
    mutate(Global_active_power = as.numeric(Global_active_power),
           Sub_metering_1 = as.numeric(Sub_metering_1), 
           Sub_metering_2 = as.numeric(Sub_metering_2),
           Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
    # put Date and Time columns in Date/Time format
    mutate(Date = dmy(Date)) %>%
    mutate(datetime = ymd_hms(paste(Date, Time)))


# make and save the plot with three Sub_metering values

plot(thisdf$Sub_metering_1 ~ thisdf$datetime, type = "l", xlab ="", ylab = "Energy sub metering", col = "black", yaxt = "n")
axis(2, at = x <- seq(0,40, by = 10), labels= x)
lines(thisdf$Sub_metering_2 ~ thisdf$datetime, type = "l", col = "red")
lines(thisdf$Sub_metering_3 ~ thisdf$datetime, type = "l", col = "blue")
legend("topright", lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png")
dev.off()
