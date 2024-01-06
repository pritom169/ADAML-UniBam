shower_data <- read.csv("Shower_data.csv", header = TRUE, sep = ";")
shower_survey <- read.csv("Shower_survey_data.csv", header = TRUE, sep = ";")

# 1.Compute the average Showertime using mean().
average_showertime <- mean(shower_data$Showertime)


# 2. Compute the Showertime variance with var().
variance_showertime <- var(shower_data$Showertime)

# 3. Compare the mean showertime with median.
median_showertime <- median(shower_data$Showertime)
cat("Average Showertime:", average_showertime, "\n")
cat("Median Showertime:", median_showertime, "\n")

# 4. Compute the standard deviation of Volume with sd()
standard_deviation <- sd(shower_data$Volume)

# 5. Apply quantile() to ShowerTime. How can you access the individual values of the output?
# In R, the quantile() function is used to compute sample quantiles. A quantile is a measure
# that divides.a dataset into equal-sized portions. The most commonly used quantiles are the 
# median (which divides the data into two halves) and quartiles (which divide the data into 
# four quarters). However, quantile() can be used to compute any desired quantile.
quantile_data <- quantile(shower_data$Showertime)
# In order to access the first quantile we need to use this
# Accessing the first element.
cat(quantile_data[1])

# 6. Define your own function range(), which takes a vector as an input and
# returns the difference between the maximal (max()) and the minimal value
# (min()) of the vector
range <- function(vector){
  return (max(vector) - min(vector))
}

# 7. Apply your function to the Volume of showers.
range(shower_data$Volume)

#### dplyr 1
library(dplyr)
# 8. Select all the showers from Hoursehold "6395" and assign these to varaible "a".
a <- filter(shower_data, Hh_ID == 6395)

# 9. Order the showers of household "6395" by the recorded Volume and assign these
# these to variable "b".
# Arrange sortes the data by volume.
b <- arrange(a, Volume)

# 10. Select all the showers with the exception of Household "6395" and "5307" and
# assign them to "c".
c <- filter(shower_data, !Hh_ID %in% c(6395, 5307))


#### dplyr 2
# 11. Determine the maximum and the minimum shower duration of the data set using
# "summarise"
d <- summarise(shower_data, minShowerDuration = min(Showertime),
               maxShowerDuration = max(Showertime))

# 12. Introduce a new column "Avgtemperaturefahrenheit" using "mutate". Therefore,
# convert the column "Avgtemperature" to Fahrenheit unit using the package "weathermetrics"
shower_data$Avgtemperature <- as.numeric(shower_data$Avgtemperature)
e <- dplyr::mutate(shower_data, Avgtemperaturefahrenheit = 
                     weathermetrics::celsius.to.fahrenheit(Avgtemperature))

# 13. Calculate the average shower volume for each household, the average shower temperature
# and the average shower duration, (Hint: Use "group_by", followed by "summarise")

# What group by does is that, it collects all the data and groups by the particular
# attribute
grouped_showers <- group_by(shower_data, Hh_ID)
measures <- summarise(grouped_showers, meanDuration = mean(Showertime),
                      meanTemperature = mean(Avgtemperature),
                      meanVolume = mean(Volume))


#### dplyr 3
# Use piping (the symbol %>% ) to solve the following exercises:
#14. Calculate for each household/device the average shower volume, the average shower
# temperatuyre and average shower duration.
measures <- shower_data %>% group_by(Hh_ID) %>%
  summarise(meanDuration = mean(Showertime),
            meanTemperature = mean(Avgtemperature),
            meanVolume = mean(Volume))

#15. Determine the number of household/device, which have recorded more than 50 showers.
moreThan50 <- shower_data %>% group_by(Hh_ID) %>%
  summarise(n = n()) %>% filter(n > 50)

# What n = n() does here is that, it generates the number of datas are in a particular
# data group.

#16. Calculate the average number of recorded showers per group.
avgNumberOfShowers <- shower_data %>% group_by(Hh_ID, group) %>%
  summarise(n = dplyr::n())
  group_by(group) %>%
  summarise(grpmean = mean(n))

# group_by(Hh_ID, group), It groups all the data points by Hh_Id and puts them
# one after another.
