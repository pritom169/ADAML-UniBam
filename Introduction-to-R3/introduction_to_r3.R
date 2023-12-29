library(dplyr)
# Load and inspect the Shower data
data <- read.csv2("Shower_data.csv")

# the group is not meaningful as numeric! Convert it to factor
data$group <- as.factor(data$group)
#level names of factors can be changed - mind the order of the elements!
levels(data$group) <- c("First group", "Second group", "Third group",
                        "Fourth group", "Fifth group", "Sixth group")



##Exercises: Joining data

#1. Download the data set “Shower_survey_data.csv” from the edX site and load it in R.
survey <- read.csv2("Shower_survey_data.csv")

#2. Perform an inner join on the shower and the survey data (based on ”Hh_id”).
combined_dataset <- dplyr::inner_join(data,
                                      survey)
#3. Group the data frame by the column “X03d_longhair” and “gruppe” and summarize the data frame by calculating the average shower volume and the average shower duration.
result <- combined_dataset %>% dplyr::group_by(X03d_longhair, group) %>%
  dplyr::summarise(avgVolume = mean(Volume),
                   avgDuration = mean(Showertime))




##ggplot2
library(ggplot2)

#Exemplary plots
g <- ggplot(data, aes(x=Avgtemperature, y=Volume))
g <- g + geom_point()
g

g <- g + ggtitle("Distribution of average temparature and volume")
g <- g + xlab("Temperature")
g <- g + ylab("Volume in liters")
g <- g + geom_hline(yintercept = mean(data$Volume), color="red")
g

g <- ggplot(data, aes(x=Avgtemperature, y=Volume, color=factor(group)))
g <- g + geom_point()
g

g <- ggplot(data, aes(x=Avgtemperature, y=Volume))
g <- g + geom_point()
g <- g + facet_wrap(~group, nrow = 1)
g



#Exercise ggplot2
#4. Visualize shower time and volume by creating a scatter plot.
g <- ggplot(data, aes(x=Showertime, y=Volume))
g <- g + geom_point()
g

#5. Use logarithmic scale for the plot.
g2 <- ggplot(data, aes(x=log(Showertime), y=log(Volume)))
g2 <- g2 + geom_point()
g2

#6. Create a boxplot of shower time.
g3 <- ggplot(data, aes(x="",y=Showertime))
g3 <- g3 + geom_boxplot()
g3

#7. Plot a bar graph of the income column (displaying the number of households per income category).
g4 <- ggplot(survey, aes(x=as.factor(einkommen)))
g4 <- g4 + geom_bar()
g4

#8. Create a density plot of the shower volume using facetting on the group variable.
g5 <- ggplot(data, aes(x=Volume ))
g5 <- g5 + geom_density()
g5 <- g5 + facet_wrap(~group)
g5

#9. Create a plot that shows how the average volume per shower changes over the first 50 showers (-->"Shower" variable).
#Hint: Use dplyr to create a new dataframe for this plot
perDay <- data %>%filter(Shower<51)%>%group_by(Shower)%>% summarise(meanVol=mean(Volume))

g6 <- ggplot(perDay, aes(x=Shower, y =meanVol  ))
g6 <- g6 + geom_line()
g6

#10. Does this trend over time differ per group?
perDayAndGroup <- data %>%filter(Shower<51)%>%group_by(Shower, group)%>% summarise(meanVol=mean(Volume))

g7 <- ggplot(perDayAndGroup, aes(x=Shower, y =meanVol, color=factor(group)  ))
g7 <- g7 +geom_vline(xintercept =10,color="black")+ geom_line()+ facet_wrap(~group)
g7




#11. Loop over the Shower dataset and create a new variable “ExperimentalGroup”. It should have the value “Control” if the group variable is 1 or 2, and “Intervention” otherwise.

data$ExperimentalGroup <- ""

for(i in 1:nrow(data)){
  if(data$group[i]=="First group"|data$group[i]=="Second group"){
    data$ExperimentalGroup[i] <- "Control"
  }else{
    data$ExperimentalGroup[i] <- "Intervention"
  }
}

#12. Complete the same task as before, but without a loop: create a function and use "sapply()" instead.

decideGroup <- function(value){
  if(value=="First group"|value=="Second group"){
    return("Control")
  }else{
    return("Intervention")
  }
}
data$ExperimentalGroup2 <- sapply(data$group, decideGroup)


#Alternative: vectorised if
data$ExperimentalGroup3 <- ifelse(data$group=="First group"|data$group=="Second group",
                                  "Control",
                                  "Intervention")




