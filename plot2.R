makeplot2 <- function()
{
    library(lubridate)
    library(data.table)
    
    #Read the data from R if already present
    list <- ls(.GlobalEnv)
    if("courseradata" %in% list)
    {
        data <- get("courseradata",envir = .GlobalEnv)
    }
    #Read Data from file if not already present in R's global environment
    else
    {
        #Download and unzip file if not already present
        if(length(grep("counsumption",list.files(pattern = ".txt")))==0)
        {
            if(length(grep("consumption",list.files(pattern = ".zip")))==0)
            {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
            }
            unzip("exdata-data-household_power_consumption.zip")
        }
        data <- read.delim("household_power_consumption.txt",sep=";", na.strings = "?", skip = 66636, nrows = 2880)
        data <- data.table(data)
        names(data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
        #Process Time Stamp
        data$Time <- paste(data$Date,data$Time)
        data$Time <- dmy_hms(data$Time)
        data <- data[,Date:=NULL]
    }
    
    #Plotting
    png(filename = "plot2.png")
    plot(data$Time,data$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)", xlab = " ")
    dev.off()
}
makeplot2()