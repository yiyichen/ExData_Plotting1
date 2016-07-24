library(RSQLite)

## Coursera > Exploratory Data Analysis
## Peer Graded Assignment: Course Project 1 - Plot 4

## NOTE: This code assumes that you have already downloaded and unzipped
## the household power consumption data, and placed in the same directory
## as the script. Please feel free to update the value of the "value" parameter 
## in the dbWriteTable function call (line 18) accordingly to the appropriate 
## file directory of the data

## Read data
## Create a temporary database on disk and load data into the database
con <- dbConnect(SQLite(), dbname = "")

print("Loading data")
dbWriteTable(con, name="tmp_table", 
             value="household_power_consumption.txt", 
             row.names = FALSE, header = TRUE, sep = ";")

## Get consumption data between Feb 1 - 2, 2007
query <- "SELECT * FROM tmp_table WHERE Date='2/2/2007' OR Date = '1/2/2007'"
consumption.data <- dbGetQuery(con, query)

## Create a new POXIXlt project with the original date and time 
consumption.data$New_time <- 
    strptime(paste(consumption.data[,1], consumption.data[,2]), 
             format = "%d/%m/%Y %H:%M:%S")

## Close database connection
dbDisconnect(con)

## Make plot 4
print("Making plot 4")

## Launch png device
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

## Make plots
with(consumption.data, {
    ## Make plot (1, 1)
    plot(New_time, Global_active_power, 
         type = "l", xlab = "", ylab = "Global Active Power")
    
    ## Make plot (1, 2)
    ## Set x label to blank (instead of "datetime" in the instruction) to
    ## maintain consistency across the plot
    plot(New_time, Voltage, type = "l", xlab = "")
    
    ## Make plot (2, 1)
    plot(New_time, Sub_metering_1, 
         type = "l", xlab = "", ylab = "Energy sub metering")
    lines(New_time, Sub_metering_2, col = "red")
    lines(New_time, Sub_metering_3, col = "blue")
    legend("topright", 
           bty = "n",
           c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
           lty = 1,
           col = c("black", "red", "blue"))
    
    ## Make plot (2, 2)
    ## Set x label to blank (instead of "datetime" in the instruction) to
    ## maintain consistency across the plot
    plot(New_time, Global_reactive_power, 
         type = "l", xlab = "", ylab = "Global Reactive Power")
})

dev.off()
print("Completed!")