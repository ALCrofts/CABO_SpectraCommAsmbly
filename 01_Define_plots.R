# Author: Anna L. Crofts, email: croftsanna@gmail.com

# Title: Code for the manuscript, "Testing the scale dependence of community assembly processes using imaging spectroscopy"

# Section 01: Defining preliminary plots 

# 1.0_Load Packages etc. --------------------------------------

# Load Packages
library(sf)
library(dplyr)
library(ggplot2)
library(ggspatial)

# 1.1_Define preliminary plots   ---------------------------------------------------------------------
## Randomly place plots of the largest spatial grain across Parc national du Mont-Mégantic (PNMM), where plots can never overlap. 

# Load PNMM shapefiles (including, Samuel-Brisson ecologic reserve)
Meg_boundary <- st_read("Data/Limits/fond_parc.shp") #PCMM boundaries
Res_boundary <- st_read("Data/Limits/fond_reserve.shp") #Reserve ecologique Samuel-Brisson boundaries

# Merge park boundry and reserve boundary spatial features
Meg_boundary<- st_union(Meg_boundary, Res_boundary) %>%
  dplyr::select('geometry') %>%
  st_set_crs("EPSG:32187") %>%
  nngeo::st_remove_holes()

st_write(Meg_boundary, dsn = 'Outputs/Data/Meg_boundary.geojson', driver = 'GeoJSON', overwrite = T)

# Set buffer equal to plot radius, so plots will be contained within PNMM boundaries
Meg_boundary_buf <- Meg_boundary %>%
  st_buffer(dist = -178) # largest spatial grain has a radius = 178m

plot(Meg_boundary)

# Randomly assign plot centers of largest spatial grain (radius = 178m) 
potential_plots <- st_sample(x = st_as_sfc(Meg_boundary_buf), # convert boundary polygon to simple feature geometry 
                      type = "SSI", # SSI arguement means that after the first random point, subsequent points are only accepted if they are farther than the threshold distance
                      n = 325, # number of plots to establish (define lots b/c some will be discarded later due to cloud shadow) 
                      r = 357) # threshold distance, slightly more than the diameter of the largest grain

plot(potential_plots, pch = 20, col = "grey25")

# Add plot ids and reproject to match HSI data
potential_plots2 <- potential_plots %>%
  mutate(plot_id = 1:n()) %>%
  dplyr::select(-1) %>%
  st_set_crs("EPSG:32187") %>%
  st_transform("EPSG:32619") %>%
  mutate(lon = sf::st_coordinates(.)[,1],
         lat = sf::st_coordinates(.)[,2])

# Save plot centers of the largest spatial grain
st_write(potential_plots2, dsn = 'Outputs/Data/potential_plots.geojson', driver = 'GeoJSON', overwrite = T)

# Plot plot centres within PNMM
ggplot(potential_plots2) +
  geom_sf(data=Meg_boundary, fill = '#E4EDCB') +
  geom_sf(size = 1.5) +
  annotation_scale() +
  annotation_north_arrow(height = unit(1,'cm'), width = unit(1,'cm'), location = 'tr') +
  theme(panel.background = element_rect(fill = NA, colour = 'black'),
        panel.grid.major = element_blank(), # get rid of major grid
        panel.grid.minor = element_blank())

ggsave(filename = "Map_potential_plots.png", width = 4, height = 4)
