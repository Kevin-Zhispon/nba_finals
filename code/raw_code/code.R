install.packages("tidyverse")
library(tidyverse)

# set working directory 

setwd("/cloud/project/code/raw_code")

# Import data

champs <- read_csv("../../data/raw_data/championsdata.csv")
runners <- read_csv("../../data/raw_data/runnerupsdata.csv")
view(champs)
view(runners)
# Which column contains the team names

colnames(champs)
colnames(runners)

# find the distinct team names 

unique(champs$Team)
champs %>% select(Team) %>% distinct()
distinct(champs, Team)

unique(runners$Team)



# fix typos for heat and warriors
# HINT use mutate() and ifelse() functions 
# use pipe %>% operator

champs <- champs %>% 
  mutate(Team = ifelse(Team == "Warriorrs", "Warriors", Team)) %>%
  mutate(Team = ifelse(Team == "'Heat'", "Heat", Team))

# find class of 'Win' and 'Home' variables 

class(champs$Win)
class(champs$Home)

champs %>% pull(Win) %>% class()

# convert 'Win' and 'Home' variables to factor variables 

champs <- champs %>%
  mutate(Win = as.factor(Win)) %>%
  mutate(Home = as.factor(Home))
class(champs$Win)
runners <- runners %>%
  mutate(Win = as.factor(Win)) %>%
  mutate(Home = as.factor(Home))
class(runners$Win)


allteams <- bind_rows(champs, runners)
allteams <- bind_rows("champion" = champs, "runner" = runners, .id = "rank")

