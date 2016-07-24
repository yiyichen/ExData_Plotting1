library(RSQLite)

## Coursera > Exploratory Data Analysis
## Peer Graded Assignment: Course Project 1 - Plot 1

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

## Make plot 1
print("Making plot 1")

## Launch png device
png(filename = "plot1.png", width = 480, height = 480)

## Make plot
with(consumption.data, 
     hist(Global_active_power, 
          col = "red", 
          main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)"))

## Update y-axis
ytick <- seq(0, 1200, by = 200)
axis(2, at = ytick, labels = ytick)

dev.off()
print("Completed!")