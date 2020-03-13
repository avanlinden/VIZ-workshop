
### The Tidyverse is Your Friend! ###
### UMass Data Viz in R 3-13-2020 ###
### Abby Vander Linden ###

library(tidyverse)

### Dplyr and tibbles ====

# Dplyr is an R package that provides a flexible grammar for manipulation of dataframes
# We won't actually use any standard R dataframes here -- we will work with data as 'tibbles', or dplyr's version of tables

# let's look at the mpg dataset, which is part of the tidyverse and is formatted as a tibble
mpg

#we can easily filter the data by row -- let's say we want to look at cars that get only 30mpg or more on the highway

#first look at the filter command

?dplyr::filter

filter(mpg, hwy >= 30)

# we can filter all cars that get at least 30mpg highway and 35mpg in the city

filter(mpg, hwy >= 30 & cty >= 25) #not many!

#we can use 'select' to select columns from the data frame:

select(mpg, year, hwy)

# we can use this in conjunction with filtering
filter(select(mpg, year, hwy), hwy >= 35)

#we can also rename a column while we select it

select(mpg, city = cty, highway = hwy)

# we can edit values in columns by row according to some criterion with mutate; for example, we can create a new column that has the mpg in kilometers per liter

mutate(mpg, kmpl_hwy = hwy*0.425)

# we can sort data on certain values with arrange

arrange(mpg, hwy) #this is ascending highway mpg
arrange(mpg, desc(hwy)) #descending highway mpg

# we can count total values or instances of criteria:

count(mpg, model) # how many data points are from each model
distinct(mpg, model) # how many different models are there?

# we can group data and summarise it with various functions:

#for example, group by manufacturer and get the mean highway mpg
summarise(group_by(mpg, manufacturer), mean=mean(hwy)) 

### Load external data with readr ====

### Mutate, select, filter, summarise, arrange ====

### Gather and spread ====

### Pipe operator ====