# First step is to import the library.
library(dplyr)

# Load and inspect the data
data <- read.csv2("Shower_data.csv")

# The group has numeric values which is not meaningful
# We have to convert it to factor.
data$group <- as.factor(data$group)

In R, converting numeric variables to factors is often necessary
because many statistical models require categorical input. For example,
if you have a variable that represents different groups (like gender, 
race, etc.), it should be a factor, not a numeric 
variable.

When you convert a numeric variable to a factor, 
you're essentially telling R to treat that variable 
as categorical data. This is important because 
certain functions in R, like lm() for linear 
regression or glm() for generalized linear models, 
except categorical predictors to be factors.

Moreover, converting numeric variables to factors can 
help improve the interpretability of your model. When 
a variable is treated as a continuous numeric variable,
the model might assume a linear relationship between the 
variable and the outcome. But if the variable is actually 
categorical, treating it as such can lead to a better fit 
and more meaningful interpretation of the results.

Finally, converting numeric variables to factors can also 
be necessary for visualization purposes. Many plotting 
functions in R, like ggplot(), expect categorical variables
to be factors.

levels(data$group) <- c("First group", "Second group",
"Third group", "Fourth group", "Fifth group", "Sixth group")

###Exercise: Joining data
1. Download the data set “Shower_survey_data.csv” from the edX 
site and load it in R.

survey <- read.csv2("Shower_survey_data.csv")

2. Perform an inner join on the shower and the survey 
data (based on ”Hh_id”).

combined_dataset <- dplyr::inner_join(data, survey)

3. Group the data frame by the column “X03d_longhair” and “gruppe” 
and summarize the data frame by calculating the average shower 
volume and the average shower duration.

result <- combined_dataset %>% dplyr::group_by(X03d_longhair, group) %>%
  dplyr::summarise(avgVolume = mean(Volume), 
  avgDuration = mean(Showertime))

####ggplot2
library(ggplot2)

###Exemplary plots
g <- ggplot(data, aes(x=Avgtemperature, y=Volume))
g <- g + geom_point()
g

g <- ggplot(data, aes(x=Avgtemperature, y=Volume)) - 
This line is creating a new ggplot object g. The aes() function is used 
to map variables in your data to visual properties (aesthetics) of the plot. 

In this case, Avgtemperature is mapped to the x-axis and Volume is mapped 
to the y-axis.

g <- g + geom_point() - This line is adding points to the plot. 
geom_point() creates a scatter plot, where each point represents a 
row in the data. The position of the point is determined by the values 
of Avgtemperature and Volume.

g - This line is simply printing the plot. When you run this line 
in your R console, it will display the scatter plot.

g <- g + ggtitle("Distribution of average temparature and volume")
g <- g + xlab("Temperature")
g <- g + ylab("Volume in liters")
g <- g + geom_hline(yintercept = mean(data$Volume), color = "red")
g

g <- g + ggtitle("Distribution of average temperature and volume") - 
This line is adding a title to the plot. 
The title is set to "Distribution of average temperature and volume".

g <- g + xlab("Temperature") - This line is setting the label for 
the x-axis to "Temperature".
g <- g + ylab("Volume in liters") - This line is setting the 
label for the y-axis to "Volume in liters".
g <- g + geom_hline(yintercept = mean(data$Volume), color="red") - 
This line is adding a horizontal line to the plot at the mean value of Volume. 
The yintercept argument specifies the y-value where the line should be drawn, 
and the color argument sets the color of the line to red.

g <- ggplot(data, aes(x=Avgtemperature, y=Volume, color=factor(group)))
g <- g + geom_point()
g

ggplot(data, aes(x=Avgtemperature, y=Volume, color=factor(group))) - This is creating a new ggplot object. 
The aes() function is used to map variables in your data to 
visual properties (aesthetics) of the plot. In this case, 
Avgtemperature is mapped to the x-axis, Volume is mapped to 
the y-axis, and group is mapped to the color of the points. 
The factor() function is used to convert group into a factor 
variable, which means it will be treated as categorical data. 
Each unique level of group will be assigned a different color.

g <- ggplot(data, aes(x=Avgtemperature, y=Volume))
g <- g + geom_point()
g <- g + facet_wrap(~group, nrow = 1)
g

g <- g + facet_wrap(~group, nrow = 1) - This line is adding facets to the plot. 
Facets are subplots that show subsets of the data. The facet_wrap() function is 
used to create these subplots. The formula ~group indicates that a separate panel 
should be created for each unique value of group. The nrow = 1 argument means that 
the panels should be arranged in one column.

#### Exercise ggplot2
4. Visualize shower time and volume by creating a scatter plot.
g <- ggplot(data, aes(x=Showertime, y=Volume))
g <- g + geom_point()
g

5. Visualize shower time and volume by creating a scatter plot.
g2 <- ggplot(data, aes(x=log(Showertime), y=log(Volume)))
g2 <- g2 + geom_point()
g2

6. Create a boxplot of shower time.
g3 <- ggplot(data, aes(x="", y=Showertime))
g3 <- g3 + geom_boxplot()
g3

7. Plot a bar graph of the income column (displaying the number
of household per income category).
g4 <- ggplot(survey, aes(x=as.factor(einkommen)))
g4 <- g4 + geom_bar()
g4

8. Create a density plot of the shower volume using facetting on 
the group variable.

g5 <- ggplot(data, aes(x=Volume))
g5 <- g5 + geom_density()
g5 <- g5 + facet_wrap(~group)
g5

9. Create a plot that shows how the average volume per shower changes 
over the first 50 showers (-->"Shower" variable).
#Hint: Use dplyr to create a new dataframe for this plot
perDay <- data %>% filter(Shower<51) %>% group_by(Shower) %>%
  summarise(meanVol = mean(Volume))

g6 <- ggplot(perDay, aes(x=Shower, y = meanVol))
g6 <- g6 + geom_line()
g6

10. Does this trend over time differ per group?
perDayAndGroup <- data %>% filter(Shower<51) %>% group_by(Shower, group) %>%
  summarise(meanVol= mean(Volume))
g7 <- ggplot(perDayAndGroup, aes(x=Shower, y = meanVol,
  color = factor(group)))
g7 <- g7 + geom_vline(xintercept = 10, color = "black") +
  geom_line() + facet_wrap(~group)
g7

11. Loop over the Shower dataset and create a new variable “ExperimentalGroup”. 
It should have the value “Control” if the group variable is 1 or 2, and 
“Intervention” otherwise.

data$ExperimentalGroup <- ""
for (i in 1:nrow(data)){
  if (data$group[i] == "First group" | data$group[i] == "Second group"){
    data$ExperimentalGroup[i] <- "Control"
  } else {
  data$ExperimentalGroup[i] <- "Intervention"
  }
}

12. Complete the same task as before, but without a loop: create a function 
and use "sapply()" instead.

decideGroup <- function(value) {
  if(value == "First group" | value == "Second group"){
    return("Control")
  } else {
    return("Intervention")
  }
}
data$ExperimentalGroup2 <- sapply(data$group, decideGroup)

The sapply() function in R is a powerful tool for applying a function over a 
list or vector. It simplifies the output to the most elementary data structure.

Sample use for sapply(the data field, the function that decides the logic)

#Alternative: vectorised if
data$ExperimentalGroup3 <- ifelse(data$group %in% c("First group","Second group")
  ,"Control", "Intervention")

ifelse(test, yes, no) is a function that checks if a condition is met. If the condition is true, 
it returns the value specified in the yes argument. If the condition is false, it returns the value 
specified in the no argument.