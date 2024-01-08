library(dplyr)
library(ggplot2)

#Load the data
Shower_data <- read.csv2("Shower_data.csv")
Survey_data <- read.csv2("Shower_Survey_data.csv")

#Remove the first shower, create groups
Shower_data <- Shower_data %>% dplyr::filter(Shower != 1) %>%
  dplyr::mutate(isTreatment = ifelse(group %in% c("1","2"), FALSE, TRUE),
                isIntervention = ifelse(Shower <= 10, FALSE, TRUE))

 
# 1. Create the model for the DiD effect--------------------------------------------- 


# Optional: Vizualize the DiD model -------------------------------------------------



# Qualitative Influence -------------------------------------------------------------
table(Survey_data$sem05_unnuetz)

Shower_data <- dplyr::left_join(Shower_data, 
                                Survey_data,
                                "Hh_ID") %>% 
               dplyr::rename(unnuetz = sem05_unnuetz)

## Reverse scale; A positive value of unnuetz means now that the participants thinks that the device is useless
## Scale(-3,-2,-1,0,1,2,3): -3: very useful, 3: very useless
Shower_data$unnuetz <- Shower_data$unnuetz * -1

