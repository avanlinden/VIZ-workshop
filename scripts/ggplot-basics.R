
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

mpg_plot +
  ggtitle("Title!")

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

?geom_density

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
    geom_boxplot() + #add the boxplot geometry
    xlab("Fighting Style") +
    ylab("log Centrum Width") +
    ggtitle("Title!")

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
    geom_point(size = 0.5) + #point geometry
    facet_wrap(~ vertebra) #facet wrap by vetebra

#seriously faceting is the best

### Color and shape scales ====

#we can control how a plot maps individual data values to the aesthetic values with scales

#discrete groups: color based on fighting style
vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
    ggplot(aes(x = logBMSS, y = logValue, color = fightStyle)) +
      geom_point()

# we can also add shapes; e.g., males and females have different shapes
vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, color = fightStyle, shape = sex)) +
  geom_point()

# we can specify which colors by adding a 'scale' layer

vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, color = fightStyle)) +
    geom_point() +
    scale_color_manual(values = c('green', 'pink')) 

### Labels and text ====

#you can adjust plot titles, axis labels, and other text pretty easily

vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, color = fightStyle, shape = sex)) +
  geom_point() +
  ggtitle("Centrum Width vs Body Mass in Ruminant Mammals") +
  xlab("log Body Mass") +
  ylab("log Centrum Width")

#can move or adjust the legend:
vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, color = fightStyle, shape = sex)) +
  geom_point() +
  ggtitle("Centrum Width vs Body Mass in Ruminant Mammals") +
  xlab("log Body Mass") +
  ylab("log Centrum Width") +
  theme(legend.position = 'bottom')

#we can add labels to individual points -- I sometimes found it helpful for data exploration but not always final figures
vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, label = spp)) + # add a label argument to the aesthetic mappings
  geom_point() +
  geom_text(size = 2, vjust = -1) #add a geom_text layer

### Themes ====

#the theme layer controls a number of aspects of how the graph looks and there are lots of pre-built themes available! I personally hate the default theme and always use theme_classic or theme_minimal

vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, color = fightStyle, shape = sex)) +
  geom_point() +
  ggtitle("Centrum Width vs Body Mass in Ruminant Mammals") +
  xlab("log Body Mass") +
  ylab("log Centrum Width") +
  theme_classic() # better theme!

vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, color = fightStyle, shape = sex)) +
  geom_point() +
  ggtitle("Centrum Width vs Body Mass in Ruminant Mammals") +
  xlab("log Body Mass") +
  ylab("log Centrum Width") +
  theme_dark() #maybe not as helpful here

# there are also tons of other available themes in the package ggtheme

install.packages("ggthemes")
library(ggthemes)

vertData %>% 
  filter(vertebra == 'C2' & measure == 'CW') %>% 
  ggplot(aes(x = logBMSS, y = logValue, shape = sex)) +
  geom_point() +
  ggtitle("Centrum Width vs Body Mass") +
  xlab("log Body Mass") +
  ylab("log Centrum Width") +
  theme_wsj(base_size = 10) #just kidding, we know the Wall Stree Journal would never publish the word "sex"

#if there's a theme you want, probably someone has made it!

### Color palettes and other fun stuff ====

# people who are much smarter and aesthetically gifted than me have made a wealth of R color palettes that are useful for visualizing data

#RColorBrewer

library(RColorBrewer)

display.brewer.all()

#discrete data with color brewer
mpg %>% 
  ggplot(aes(x = cty, y = hwy, color = drv )) +
    geom_point() +
    scale_color_brewer(palette = 'Set1')

#use "color_distiller" for continuous data

mpg %>% 
  ggplot(aes(x = cty, y = hwy, color = cyl )) +
  geom_point() +
  scale_color_distiller(palette = 'Spectral') #ok, # of cylinders isn't really continuous, but it is in this dataset

#my favorite palette: Viridis!

install.packages("viridisLite")
library(viridisLite)

#Viridis with discrete data:

#texas housing data before Viridis
txsamp <- subset(txhousing, city %in%
                   c("Houston", "Fort Worth", "San Antonio", "Dallas", "Austin"))
txsamp %>% 
  ggplot(aes(x = sales, y = median)) +
    geom_point(aes(colour = city)) 

#after viridis default palette:

txsamp %>% 
  ggplot(aes(x = sales, y = median)) +
  geom_point(aes(colour = city)) +
  scale_colour_viridis_d() +
  xlim(0, 200000)


#or the viridis inferno palette
txsamp %>% 
  ggplot(aes(x = sales, y = median)) +
  geom_point(aes(colour = city)) +
  scale_colour_viridis_d(option = 'inferno') +
  theme_classic() #change the theme because the default really gets to me

### Maps =====

#you can do maps in regular ggplot, or use the extension package 'ggmaps', which is great!

#get crime data from US states
arrests <- USArrests %>% 
  rownames_to_column() %>% 
  as_tibble() %>% 
  rename(region = rowname) %>% 
  mutate(region = tolower(region))
  
#retrieve map data and merge with crime data
  
states_map <- map_data("state")
arrests_map <- left_join(states_map, arrests, by = "region")

arrests_map

# Create the map
arrests_map %>% 
  ggplot(aes(long, lat, group = group))+
    geom_polygon(aes(fill = Murder), color = "black")+
    scale_fill_viridis_c() + #viridis continuous scale
    theme_classic()
