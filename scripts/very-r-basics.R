
### Welcome to R! ###
### UMass Data Viz in R 3-13-2020 ###
### Abby Vander Linden ###


### Installing and loading packages ====

install.packages("tidyverse")

library(tidyverse)

### Storing variables and executing code ====

# Write code in an R script file, then hit Cmd + Enter (Mac) or Ctrl + Enter (PC) to excute it in the console

# this function loads the 'cars' dataset from base R; when you run it, you should see a dataframe of speed and distance values in the consol
cars

# variables are assigned with the ' <- ' operator

# this assigns the numeric value '10' to the object 'x'
x <- 10

# if we then run the code below, we should get the value of x in the console
x

# we can store multiple values in the object x by creating a vector
x <- c(1, 3, 5, 10)

# when we call this object we now see 4 numbers
x

# R functions take an object and usually some other arguments within parentheses, like this:
mean(x, na.rm = FALSE)

### Value classes and structure ====

# R can work with many different types of values, including numeric, integer, characters, factors, and logical values

# Create a vector of numeric values:
numericV <- c(3, 2, 1, 1)

numericV

# We can use class()to see what type of value an object is

class(numericV)

# The structure function (str) can provide a lot of info t:

str(numericV)

# Create a vector of numeric integer values:

numericInteger <- 1:5

numericInteger


# What type of object is this?

class(numericInteger)


# You can change between value types easily:

numericVI <- as.integer(numericV)

# did it work?
class(numericVI)


# R uses '' or "" to designate character values:

monthVector <- c('march', 'february', 'january', 'january')

monthVector

# What type of object is this?

class(monthVector)

str(monthVector)

# Logical values are TRUE or FALSE

FALSE

TRUE

as.numeric(FALSE)

as.numeric(TRUE)

### R as a calculator ====

# math functions work about like you'd expect; you can run the following code to check

5*2
5/2

# parentheses are used for order of operations

(5*2) + 2
5*(2+2)

y <- 10
y^2
sqrt(y)

# standard logical operator (==, !=, <, >, etc) work like this

3 == 3 #output should be TRUE

3 != 3 #output should be FALSE

### Getting help ====

# running a function or package name with ? in front of it will take you to the documentation for that object, like so:

?sqrt
?c
?dplyr


