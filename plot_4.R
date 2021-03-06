
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
# Date and time variable.
x = electric_power_data$Date_Time

# Global active power variable.
y = electric_power_data$Global_active_power

# Sub-metering energy variables.
y_1 = electric_power_data$Sub_metering_1
y_2 = electric_power_data$Sub_metering_2
y_3 = electric_power_data$Sub_metering_3

# Voltage.
z <- electric_power_data$Voltage

# Global reactive power.
w <- electric_power_data$Global_reactive_power

# Create plot 4.
png(filename = "./plot_4.png", width = 480, height = 480, units = "px")

par(mar = c(5.1, 5.1, 4.1, 2.1),
    mfcol = c(2, 2), 
    cex.lab = 1)

# Plot 2.
plot(x, y,
     col = "white", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(x, y)

# Plot 3.
plot(x, y_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x, y_2, col = "red")
lines(x, y_3, col = "blue")

legend("topright", 
       bty = "n", 
       border = NULL,
       col = c("black", "red", "blue"), 
       lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# New plot.
plot(x, z, 
     type = "l", 
     xlab = "",
     ylab = "Voltage (volt)")


# Second new plot.
plot(x, w, 
     type = "l", 
     xlab = "", 
     ylab = "Global_reactive_power")

dev.off()
