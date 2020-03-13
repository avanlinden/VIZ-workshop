
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

### 2D Discrete x, Continuous y: boxplot, bar plot ====

### Stats: visualize data transformation ====

### Faceting ====

### Color and shape scales ====

### Labels and text ====

### Themes ====

### Color palettes and other fun stuff ====


### Heatmaps ====

### Manhattan Plots ===