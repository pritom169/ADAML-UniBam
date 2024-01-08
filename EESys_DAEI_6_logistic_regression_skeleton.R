diabetesData <- read.csv2("diabetes.csv", stringsAsFactors = FALSE)
View(diabetesData)



# Transforming the features
diabetesData$BMI <- as.numeric(diabetesData$BMI)
diabetesData$DiabetesPedigreeFunction <- as.numeric(diabetesData$DiabetesPedigreeFunction)
diabetesData$Outcome <- as.factor(diabetesData$Outcome)




# Build a logistic regression model that explains diabetes through the BMI
model <- glm(Outcome~BMI, data = diabetesData, family = "binomial")

summary(model)




#1. Now calculate the probability of an individual with BMI 25 not having diabetes



#2. Check it against the probability of a prediction based on the model



#3. Adding age to the model



#4. Compare AICs of both models. Which one is better?



#5. Now calculate the probability of an 10-years old individual with BMI 25 not having diabetes



#6. Check it against the probability of a prediction based on the model




