# Header ------------------------------------------------------------------

# PROJECT: Project Name  
# AUTHOR: Nikki Miller
# DATE: 2022-10-31

# PURPOSE: Brief purpose on script 

# DETAILS: Key Details on script 


# Setup  ------------------------------------------------------------------
library(tidyverse)
library(ggplot2)
library(sf)
library(rgdal)


# dir <- "/Users/eliza/Data Analysis /land-use/raw_data"
dir <- "/Users/eliza/Library/CloudStorage/OneDrive-Personal/data-practice/land-use/raw_data"

# Raw Data  ---------------------------------------------------------------

# Geo 
cdta <- st_read(dsn = paste0(dir, "/nycdta2020_22b"), 
                layer = "nycdta2020") %>% 
  st_transform(4326)

# Poverty and Race Data 
poverty_raw <- read_csv(str_glue("{dir}/econ_20162020_acs5yr_cdta.csv")) #poverty 

#race 

# Facility data 
shelters <- st_read(paste0(dir, "/shelters"), 
                    layer = "facilities_filtered_2022-11-04") %>% 
  st_transform(4326) 




# Map Data ----------------------------------------------------------------

# poverty rates 
poverty_rates <- poverty_raw %>% 
  # FamBwPv - families below pov, PBwPv- below pov 
  select(1:5, c("PBwPvP")) %>% 
  mutate(PBwPvP = case_when())
  rename(CDTA2020 = "GeoID")

# merge cdta with poverty data 

cdta_poverty_rates <- cdta %>% 
  merge(poverty_rates, by = "CDTA2020") 



cdta %>% 
  ggplot(aes(fill= "PBwPvP")) +
  geom_sf(color = "#777777") +
  scale_fill_brewer(palette = "blues") +
  theme_void() +
  labs(title = "Community Districts")


# st_write(cds, dsn = path(root, "Raw", "Geospatial data", "cds_data.geojson"),
#          append = F,
#          delete_dsn = T)

