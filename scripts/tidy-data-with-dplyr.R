
### The Tidyverse is Your Friend! ###
### UMass Data Viz in R 3-13-2020 ###
### Abby Vander Linden ###

library(tidyverse)

### Dplyr and tibbles ====

# Dplyr is an R package that provides a flexible grammar for manipulation of dataframes
# We won't actually use any standard R dataframes here -- we will work with data as 'tibbles', or dplyr's version of tables

# let's look at the mpg dataset, which is part of the tidyverse and is formatted as a tibble
mpg 

### Mutate, select, filter, summarise, arrange ====

#we can easily filter the data by row -- let's say we want to look at cars that get only 30mpg or more on the highway

#first look at the filter command

?dplyr::filter

good_mileage <- filter(mpg, hwy >= 30)

# we can filter all cars that get at least 30mpg highway and 35mpg in the city

filter(mpg, hwy >= 30 & cty >= 25) #not many!

#we can use 'select' to select columns from the data frame:

select(mpg, year, hwy, make = manufacturer, model)

# we can use this in conjunction with filtering
filter(select(mpg, year, hwy), hwy >= 35)

#we can also rename a column while we select it

select(mpg, city = cty, highway = hwy)

# we can edit values in columns by row according to some criterion with mutate; for example, we can create a new column that has the mpg in kilometers per liter

mutate(mpg, kmpl_hwy = hwy*0.425, kmpl_cty = cty*0.425)

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

#readr is a flexible tidyverse package for reading in rectangular data in many different types and automatically formatting it in a tibble; more info:
?readr

#let's read in a dataframe of mammal vertebrate measures I have

verts <- read_csv("data/ruminant_vert_morph_data.csv")

# let's take a look!
verts

#because this csv had a column of row numbers, we have a weird column 'X1' at the start of the dataframe. We can get rid of it with select(-X1), and then store the result as a new object

vertData <- select(verts, -X1)
vertData

#we can filter and arrange this dataframe, too
#let's look at all measurements that belong to the species "Ovis dalli", aka Dall's sheep

filter(vertData, spp == "Ovis dalli")

### Pipe operator ====

#the pipe operator is a really handy tool for data manipulation and plotting in R
# it's basically say 'take this, AND THEN do this, AND THEN do something else'
# it's %>% , which you can get with Cmd+Shift+M

#so, take our vertData AND THEN filter it so we have just measurements from vertebra C2

filter(vertData, vertebra == 'C2')

vertData %>% 
  filter(vertebra == 'C2') 

#it's really helpful for stringing together commands, and it allows you to trouble shoot each piece without ever overwriting the original tibble

sexMean <- vertData %>% 
  filter(vertebra == 'C2') %>%  #filter only rows from vertebra C2
  mutate(valueInMeters = value*0.01) %>%   #create a new column with the measurements in meters
  group_by(sex) %>% #group males and females
  summarise(mean = mean(valueInMeters)) #look at mean measurment values for males and females

#the original tibble is unchanged!
vertData

sexMean

### Gather and spread ====

#These functions are often really hand with plotting -- they let you go from a wide data frame to a narrow one and vice versa

#spread out our data so that each different anatomical measurement on C2 has its own column
vertData %>% 
  filter(vertebra == 'C2') %>% 
  select(catNum, vertebra, measure, value) %>%  #select a few columns
  spread(key = measure, value = value) #spread the data out using the options for "measure" as the column headers, and the "value" as the values
  
#if this looks good, we can store it as a new object
wideData <- vertData %>% 
  filter(vertebra == 'C2') %>% 
  select(catNum, vertebra, measure, value) %>% 
  spread(key = measure, value = value)

# we can also collapse it and make it narrow using 'gather'

wideData %>% 
  gather(CH:TPLA, key = 'measure', value = 'value') #back to a narrow dataframe

### Mutate and filter level-ups (stringr, ifelse, relational databases, etc) ===============

#stringr is a really nice package included in the tidyverse for maniuplating strings
?stringr

#I most commonly use str_detect to filter on parts of strings, i.e., filter all the rows that belong to the genus "Ovis" 

vertData %>% 
  filter(str_detect(spp, "Ovis")) #%>% 
  #distinct(spp) #we can see this grabbed three different species in the genus Ovis without us specifying all the exact species

#str_replace is also a handy one if you need to change some strings conditionally

vertData %>% 
  mutate(spp = str_replace(spp, "Bison", "Not-a-buffalo"))

#other handy operations to look up:
#filter_if
#filter_at
#coalesce
#na_if
#replace_na
#if_else

### Join tables =======

#creating a new table with a fake variable, radness (this is a continuous variable measured using a rad-o-meter, which scans the surface of an animal and quantifies how rad it is)

sppNames <- vertData %>% distinct(spp)

radness <- round(rnorm(40, mean = 5, sd = 2.5), 2)

radBovids <- as_tibble(cbind(sppNames, radness))

#we can now join this table with our other data table

left_join(vertData, radBovids, by = 'spp')

# you can also do filtering joins; above both our tables have the same number of species, but we could filter out the radness measurements to only species that where radness > 10 (i.e. the only bovids you should associate with)

radBovids %>% 
  filter(radness > 10)  #there are now only 3 species in this table

radBovids %>% 
  filter(radness > 10) %>% 
  left_join(vertData, by = 'spp')

### Group by and summarize ===========
# the file 'lobstahs.R' in the scripts folder is some code I wrote while working with Aly Putnam on some data she has on lobster counts in the Gulf of Maine that goes through some really handy summary functions! 


### Suggestions to look into by OEB R Group members! =========

?case_when
?slice

