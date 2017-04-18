
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
    filter(Global_active_power != "?") %>%
    # change to numeric values
    mutate(Global_active_power = as.numeric(Global_active_power)) %>%
    # put Date and Time columns in Date/Time format
    mutate(Date = dmy(Date)) %>%
    mutate(datetime = ymd_hms(paste(Date, Time)))

# make and save the line plot

with(thisdf, plot(Global_active_power ~ datetime, type = "l", yaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
axis(2, at = x <- seq(0,4000, by = 1000), labels = paste(x/1000))

dev.copy(png, "plot2.png")
dev.off()


