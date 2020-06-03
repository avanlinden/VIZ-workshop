library(tidyverse)

#generate random values

trawlid <- c(sample(1:10, 100, replace=T)) #ten possible trawl sites
trapid<- c(sample(1:6, 100, replace = T)) #6 possible traps to sample at each site
obs <- c(1:100) # 100 sampling observations (still not totally clear how "no lobstahs heyah" is an observation if the trap is empty but we'll role with it)
carapace <- rnbinom(100, 10, 0.75) #fake carapace length data -- includes zeros to replicate the '0' length data meaning there were no lobsters in that trap


#create tibble at the observation level of lobsters sampled: when you pull an individual lobster out of a trap, which trap did it come from, what trawl was it on, and how long was the carapace?

lobsObs <- as_tibble(cbind(obs, trawlid, trapid, carapace)) %>% 
    mutate(present = if_else(carapace == 0, 0, 1)) #create a presence/absence vector per observation


###step one: separate lobster-level data from site-level data =======================

trapsPerTrawl <- lobsObs %>% 
  group_by(trawlid) %>% 
  summarise(traps_per_trawl = n_distinct(trapid)) #so in this data, no trawls pulled up 0 lobsters even though some traps were empty

lobsPerTrawl <- lobsObs %>% 
  group_by(trawlid) %>% 
  summarise(lobs_per_trawl = sum(present)) #how many lobsters per trawl?

#combine lobsters and traps per trawl

trawlObs <- trapsPerTrawl %>% 
  left_join(lobsPerTrawl) %>% 
  mutate(lobs_per_trap = lobs_per_trawl/traps_per_trawl) %>%  # how many lobsters per trap each trawl?
  mutate(depth = sample(20:80, 10)) #create some random depth data to go with the site


#step 2: join lobster observation data and site data for more interacting analyses 

lobsObs %>% 
  mutate(carapace = na_if(carapace, 0)) %>% #replace 0 length carapace with NA
  left_join(trawlObs)


# what is the distribution of carpace lengths each trawl?
lobsObs %>% 
  filter(carapace > 0) %>% 
  ggplot(aes(x = trawlid, y = carapace)) +
           geom_boxplot(aes(group = trawlid))

#what's the relationship between average number of lobsters and depth?
trawlObs %>% 
  ggplot(aes(x = depth, y = lobs_per_trawl)) +
    geom_point()

#what's the proportion of traps per trawl that are empty?
lobsObs %>% 
  filter(present == 0) %>% 
  group_by(trawlid) %>% 
  summarise(empty_traps = n_distinct(trapid))


#sample 10 random rows from the dataset

randomRows <- sample(1:length(lobsObs$obs), 10, replace=F) #generate random row numbers

#slice
lobsObs %>% 
  slice(randomRows)




        