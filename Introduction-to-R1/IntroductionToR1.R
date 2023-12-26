# File path
getwd()

# Loading the shower data
data <- read.csv("Shower_data.csv", header=TRUE, sep = ";")

# Get the class of the object
class(data)

# Get the dimensions of the dataframe
dim(data)

# View the first few rows of the dataframe
head(data)

# Get summary statistics for each column
summary(data)

# Get the column names of the dataframe
names(data)
