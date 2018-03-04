
# Load libraries.
library("sqldf")
library("chron")

# Load dataset.
electric_power_data <- read.csv.sql("./household_power_consumption.txt", 
                                    sep = ";", 
                                    header = TRUE, 
                                    sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007' ")


# Convert variables 'Date' and 'Time' into classes Date and times. 
electric_power_data$Date <- as.Date(electric_power_data$Date, "%e/%m/%Y")
electric_power_data$Time <- chron(times = electric_power_data$Time)

# Create plot 1 (histogram).
png(filename = "./plot_1.png", width = 480, height = 480, units = "px")
par(mar = c(5.1, 5.1, 4.1, 2.1))
hist(electric_power_data$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     col = "red")

dev.off()
