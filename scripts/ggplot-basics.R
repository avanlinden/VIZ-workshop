
### Graphics Wizardry with ggplot2 ###
### UMass Data Viz in R 3-13-2020 ###
### Abby Vander Linden ###

library(tidyverse)

### Data + aesthetic mapping + geometry ====

#To build a graph in ggplot2, we start by mapping variables in the dataset to aesthetic properties of a graph geometry (e.g., x, y, size, color)

#here we specify the data and the aesthetic mappings we want to use, then create an "empty" graph
ggplot(data = mpg, aes(x = cty, y = hwy))

#we have to add a geomtery in order to see the data

ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point()

#we can also add other layers, such as data transformations, text, coordinates, scales, and themes

ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point(aes(color = cyl)) +
  geom_smooth(method = 'lm') + 
  theme_minimal()

#it's also really handy to use the pipe operator, like so:

mpg %>%  #we are say, taking the mpg data set AND THEN build the following plot:
  ggplot(aes(x = cty, y = hwy)) +
  geom_point(aes(color = cyl)) +
  geom_smooth(method = 'lm') + 
  theme_minimal()

#you can store the plot as its own object 

mpg_plot <- ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point(aes(color = cyl)) +
  geom_smooth(method = 'lm') + 
  theme_minimal()

mpg_plot

### 1D Continuous: Histograms ====

#If we have one continuous variable, we can build density plots or histograms

mpg %>% ggplot(aes(hwy)) +
  geom_histogram()

#to see more options, use:
?geom_histogram

#we can adjust the bin width to something more useful
mpg %>% ggplot(aes(hwy)) +
  geom_histogram(binwidth = 5)

#we can use the same aesthetic mapping for a density plot by changing the geometry

mpg %>% ggplot(aes(hwy)) +
  geom_density(kernel = 'gaussian')

### 2D Continuous: points, lines ====

#you've all been waiting for it, it's time for scatter plots and line plots!
#we use an aesthetic mappy of the city mpg for x and the hwy mpg for y

mpg %>% 
  ggplot(aes(x = cty, y = hwy)) + # can use 'cty' or 'x = cty', sometimes I like to spell it out so I don't forget
  geom_point()

# you can use geom_smooth to add a layer with a smoothing function; default is a loess smoother

mpg %>% 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

### 2D Discrete x, Continuous y: boxplot, bar plot ====

#boxplots! Let's use my ruminant vertebra data and practice a little pre-plot tidying:

vertData

#we will make a boxplot of C2 centrum width for the two different groups of fighting behaviors:

vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% #filter the data
  ggplot(aes(x = fightStyle, y = logValue)) + #map fighting style to the x axis and centrum width to the y
    geom_boxplot() #add the boxplot geometry

### Stats: visualize data transformation ====

# you can use a stat layer to transform the original dataset

# so we can do a 2d density contour plot of our mpg data
mpg %>% 
  ggplot(aes(x = cty, y = hwy)) +
  stat_density2d(contour = TRUE,n = 100)

### Faceting ====

#we can create multiple 'facets' of a plot based on one or more discrete variables:

#let's look at centrum width versus body mass for each of the seven vertebrae:
vertData %>% 
  filter(measure == 'CW') %>% #filter the data
  ggplot(aes(logBMSS, logValue)) + #map x and y variables
    geom_point() + #point geometry
    facet_wrap(~ vertebra) #facet wrap by vetebra

#seriously faceting is the best

### Color and shape scales ====

### Labels and text ====

### Themes ====

### Color palettes and other fun stuff ====


### Heatmaps ====

### Manhattan Plots ===