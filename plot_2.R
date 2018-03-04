
# Load libraries.
library("sqldf")

# Set aspects of the locale for the R process.
Sys.setlocale("LC_ALL","en_US.UTF8")

# Load dataset.
electric_power_data <- read.csv.sql("./household_power_consumption.txt", 
                                    sep = ";", 
                                    header = TRUE, 
                                    sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007' ")


# Convert variables 'Date' and 'Time' into classes Date and times. 
electric_power_data$Date <- as.Date(electric_power_data$Date,format = "%d/%m/%Y")
date_time <- paste(electric_power_data$Date, electric_power_data$Time)

# Add new column to table with the date and the time.
electric_power_data$Date_Time <- as.POSIXct(date_time)

# Plot variables.
x = electric_power_data$Date_Time
y = electric_power_data$Global_active_power

# Create plot 2.
png(filename = "./plot_2.png", width = 480, height = 480, units = "px")

par(mar = c(5.1, 5.1, 4.1, 2.1))
plot(x, y,
     col = "white", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(x, y)

# Save in PNG file.
dev.off()

