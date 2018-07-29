##############################################
### Script to change raw data files into 
### data files to be used by the course 
##############################################

## Loading required packages
library(tidyverse)

## Reading raw data files 
full_data_file <- read.csv("C:/Workspace/r-learning/data/raw/Melbourne_housing_FULL.csv",
                           stringsAsFactors = FALSE)

less_data_file <- read.csv("C:/Workspace/r-learning/data/raw/MELBOURNE_HOUSE_PRICES_LESS.csv",
                           stringsAsFactors = FALSE)

## Creating data frame for Suburb matching
## which is not available in the less version
## of the data set, which we will be using
## as it is more accurate 
suburb_data <- full_data_file %>% 
  distinct(Suburb, Distance, CouncilArea, Regionname) %>%
  filter(CouncilArea != "#N/A") %>%
  mutate(Distance = as.numeric(Distance)) %>%
  group_by(Suburb, CouncilArea, Regionname) %>%
  summarise(Distance = mean(Distance, na.rm = TRUE))


## Renaming columns in data frames to consistent formats
suburb_data <- suburb_data %>%
  rename(suburb = Suburb,
         distance_from_city = Distance,
         council_area = CouncilArea,
         region_name = Regionname)

less_data_file <- less_data_file %>%
  rename(suburb = Suburb,
         address = Address,
         rooms = Rooms,
         type = Type,
         price = Price,
         method = Method,
         selling_agent = SellerG,
         dt = Date)

## Writing files into processed data folder for use
## in the course 
write.csv(less_data_file,
          "C:/Workspace/r-learning/data/processed/melbourne_housing_market.csv",
          row.names = FALSE)

write.csv(suburb_data,
          "C:/Workspace/r-learning/data/processed/suburb_data.csv",
          row.names = FALSE)