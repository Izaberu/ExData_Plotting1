
library(dplyr)
library(lubridate)


# set working directory
setwd("C:/Users/me/Dropbox/Rprogramming/course4/week1/programmingassignment")

# download data
file_path_data <- "./household_power_consumption.txt" 
mydata <- read.table(file_path_data, header = TRUE, sep=";")


# Create tbl so we can work with dplyr
mydf <- tbl_df(mydata)
View(mydf)


# subset the data from 2007-02-01 and 2007-02-02
thisdf <- mydf %>% 
    filter(dmy(Date) %in% c(ymd("2007-02-01"), ymd("2007-02-02"))) %>%
    mutate(Global_active_power = as.numeric(Global_active_power))


# make and save the histogram
hist(thisdf$Global_active_power, breaks = seq(0, 4000, by=250), col = "red", xlab = "Global Active Power (kilowatts)",
     xaxt = "n", main = "Global Active Power")
axis(1, at = x <- seq(0,4000, by = 1000), labels = paste(x/1000))
dev.copy(png, "plot1.png")
dev.off()


