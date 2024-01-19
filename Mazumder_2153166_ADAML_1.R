library(dplyr)
library(ggplot2)
# Read the CSV file
data <- read.csv2("Shower_data.csv")
#load and prepare survey dataset
survey <- read.csv2("Shower_survey_data.csv")

combined_dataset <- dplyr::inner_join(data, survey)

# 1. Add the Energy consumed for every shower.
combined_dataset$Energy <- combined_dataset$Volume * ((combined_dataset$Avgtemperature - 12) * 0.65) * (4.184/3600)

# 2. Calculate the correlation matrix
cor_matrix <- cor(combined_dataset[c("Energy", "Showertime", "Flowrate", "Avgtemperature", "Breaktime")])

# 3. Extract the correlation coefficients
cor_energy <- cor_matrix["Energy", c("Showertime", "Flowrate", "Avgtemperature", "Breaktime")]

# 4. Create a data frame for plotting
cor_data <- data.frame(Factors = names(cor_energy), Correlation = cor_energy)

# 5. Plot the correlation coefficients
ggplot(cor_data, aes(x = Factors, y = Correlation)) +
  geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
  labs(title = "Correlation with Energy Consumption",
       x = "Factors",
       y = "Correlation Coefficient") +
  theme_minimal()