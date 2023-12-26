# Exercise 1
##### Compute the following expressions:
1. 2 + 3 ∗ 52 -> 158
2. (2^3)^5
3. 3e^5+2 -> 3 * exp(5) + 2
4. 1.4E-2 -> 1.4E-2
5. log2(33554432) -> log2(33554432)
6. sin (𝜋/2) -> sin(pi/2)

##### Objects and assignments:
7. A vector containing „a“ and „b“
```R
c(“a”, “b”)
```
8. A vector containing 3, 7, 11, 15 
```R
c(3,7,11,15)
```
9. A vector with all integers from 1 to 10, save this result in variable u
```R
u <- 1:10
```
10. A vector with 10 random integers lower than 100, saves this result in variable x. (Hint: use the “sample()” function)
```R
x <- sample(1:99, 10)
```
##### Working with Vectors:
11. Display the first 3 elements of x
```R
sort(my_vector)
```
12. Apply sort() to the vector x
```R
x -> order(x)
```
Note: What order does is sort the indexes on the basis of (if the whole vector was sorted.)
13. Apply order() to the vector x ->
    Note: What order does is sort the indexes if the whole vector was sorted.
14. Try to sort x by using only order() and []
```R
x <- c(5,2,4,1,3)
ordered_idx <- order(x) (4,2,5,3,1)
sorted_x <- x[ordered_idx]
```
15. Display all even numbers of x
```R
x <- c(2,7,9,6,11)
even_idx <- x %% 2 == 0
even_numbers <- x[even_idx]
```
16. Create a vector v containing the squared values of x
```R
x <- c(1,2,3,4,5)
v <- x^2
```
17. Increase every value of vector u by one
```R
u <-c(1,2,3,4,5)
x <- u + 1
```
18. Divide v by x
```R
v/x
```
19. Calculate the square root of vector v
```R
sqrt(v)
```
20. What does x+0:1 do?
If x is (1,2,3) then what it does (1 + 0, 2+ 1, 3) which makes it (1,3,3)

##### Matrices:
21. Create a 2x2 matrix with all values being 0
```R
matrix <- replicate(2, numeric(2))
```
22. Create a matrix from vector x with two rows 
```R
# Vector x
x <- c(1, 2, 3, 4)

# Create a matrix from the vector with two rows
matrix <- matrix(x, nrow = 2, byrow = TRUE)
```
23. Save the last matrix in the variable A
```R
A <- matrix
```
24. Retrieve the first row of A
```R
# In R, you can retrieve the first row of a matrix by using indexing. Indexing in 
# R starts from 1, so to retrieve the first row, you can use the index 1.
# Assuming 'A' is the matrix
first_row <- A[1, ]

# This script will print the first row of the matrix A. Note that the result will be a 
# vector because a matrix in R is essentially a list of vectors (columns), and when you 
# index a matrix to retrieve a single row, R simplifies the result to a vector 2, 4.
first_row_as_matrix <- A[1, , drop = FALSE]
```

25. Compute the sum of matrix A without the second column
```R
# In R, you can compute the sum of a matrix without considering a specific 
# column by excluding that column during the summation. This can be done by 
# selecting all columns except the second one using negative indexing.
# Assuming 'A' is the matrix
sum_without_second_column <- sum(A[, -2])
```

26. Download the Shower data file from edX and load it into R.
```R
# Loading the shower data
data <- read.csv("Shower_data.csv", header=TRUE, sep = ";")
```

27. Try to use class(), dim(), head(), summary() and names() commands on the
    dataset. What do the results tell you?
```R
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
```

28. Convert the columns into the right data types (numeric, character, factor, …)
    Apply summary() to shower once again.
```R
# Loading the shower data
data <- read.csv("Shower_data.csv", header=TRUE, sep = ";")

# Convert columns to appropriate data types
data$group <- as.factor(data$group)
data$Totalshowers <- as.character(data$Totalshowers)
data$Shower <- as.integer(data$Shower)

summary(data)
```