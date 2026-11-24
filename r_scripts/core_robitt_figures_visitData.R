### Create core ROBITT Figures for OCCUPANCY MODELS ###
# APerson - Feb 2023 #

rm(list=ls()) # clear R

require(BRCmap)
require(dplyr)
require(occAssess)
library(ggplot2)
require(cowplot)
library(reshape2)

### add data - there are many locations of source data -----
#load("XXX_local_link/BNM_2022_1km_visitData.rdata")
#load("XXX_local_link/records_E&D_20212604_visitData.rdata")
visitData <- readRDS("XXX_local_link/bees_visit_data_BPerson_2023.rds")
#visitData <- readRDS("XXX_local_link/Orthoptera_20221020_visitData.rds")
#load("XXX_local_link/BNM_formattedOccData_2022.rdata")
#load("input_data/odonata_2022.rdata")

identifier <- "Bees_BPerson_2023" # Which group are we running?

# convert species info to long format
temp_long <- melt(visitData$spp_vis, id.vars=c("visit"))
temp_long <- temp_long[temp_long$value == TRUE,]

dat <- merge(visitData$occDetdata, temp_long)

# drop rep of ireland records
gb_recs <- read.csv("sq1km_country_id_border_dropped.csv", header = TRUE)
nrow(dat)
dat <- dat[dat$site %in% gb_recs[gb_recs$ENGLAND == 1 | gb_recs$SCOTLAND == 1 | gb_recs$WALES == 1 | gb_recs$NORTHERN_IRELAND == 1, "SQ1_SQUARE"], ]
nrow(dat)

# these are group specific changes to the data
if(identifier == "BNM_2022_1km"){ 
  dat <- dat[dat$TP < 2020,] # drop years after 2019
}

if(identifier == "Hoverflies_BPerson_2023"){
  dat$TP <- dat$TP+1969 # convert TP from numbers (1, 2, 3, 4...), to year
}

if(identifier == "Bees_BPerson_2023"){
  dat$TP <- dat$TP+1979 # convert TP from numbers (1, 2, 3, 4...), to year
}

# Which data to run, all or modeled data (following nyr site removal)
data_run <- "modelled_data" # "modelled_data" or "all_data" # This is a filter specific to occupancy models, all = all data, modelled = sites included must have records in at least 2 years.

# These are the periods used for the plot maps below.
#periods =  as.list(seq(1992,2021,1))
#grouped_periods = list(1992:1996, 1997:2001, 2002:2006, 2007:2011, 2012:2016, 2017:2021)
periods =  as.list(seq(1970,max(dat$TP),1))
grouped_periods = list(1970:1982, 1983:1992, 1993:2002, 2003:2012, 2013:max(dat$TP))

# drop data if running modelled data (sites recorded in only one year dropped)
if(data_run == "modelled_data"){
  
  # drop sites visited in less than 2 years
  drop_1_year_sites <- unique(dat[,c("site", "TP")])
  sites_to_keep <- data.frame(table(drop_1_year_sites$site))
  sites_to_keep <- sites_to_keep[sites_to_keep$Freq > 1, "Var1"]
  
  dat <- dat[dat$site %in% sites_to_keep, ]
  
}
nrow(dat)

### produce a text file containing key numbers (number of visits, sites, species) -----
txt <- paste0(identifier, " ", data_run, ". Number of visits: ", nrow(dat), ". Number of sites: ", length(unique(dat$site)), ". Number of species: ", length(unique(dat$variable)))
write.table(txt, file = paste0("XXX_local_link/", identifier, "_", data_run, "_key_data_numbers.txt"))

### estimate repeat visit metrics -----
temp_data <- unique(dat[,c("site", "TP", "visit")]) # create a table of site, year and visit unique rows
temp_data$si_ye <- paste(temp_data$site, temp_data$TP, sep = "xxx") # create an identifier which is site added to year seperated by xxx
mean(table(temp_data$si_ye)) # this is the mean number of repeat visits across all sites and year
txt <- paste0(identifier, ". Mean number of visits to site per year: ", mean(table(temp_data$si_ye))) # create a text file explaining what this is
write.table(txt, file = paste0("XXX_local_link/", identifier, "_", data_run, "_mean_vis_per_site_year.txt")) # save the text file
vis_per_year <- data.frame(table(temp_data$si_ye))# create a dataframe of number of visits per site year combination
vis_per_year$year <- as.numeric(as.character(sub(".*xxx", "", vis_per_year$Var1))) # add year back in

# plot mean number of visits to sites per year.
mean_vis_plot <- data.frame(year = 1970:max(dat$TP), mean_visits = 0) # create an empty dataframe

for(i in 1:nrow(mean_vis_plot)){
  mean_vis_plot[i, "mean_visits"] <- mean(vis_per_year[vis_per_year$year == mean_vis_plot[i,"year"], "Freq"]) # loop thourhg years, fill the empty dataframe with the mean number of visits across all sites per year
}

mv_plot <- ggplot(data=mean_vis_plot, aes(x=year, y=mean_visits, group=1)) +
  geom_line(size = 1.1) +
  geom_point(size = 1.5) +
  theme_bw() +
  xlab("Year") +
  ylab("mean number of visits") +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))

mv_plot

ggsave(filename = paste(identifier, "_", data_run, "_mean_repeat_visits_plot.png", sep = ""), plot = mv_plot, 
       path = "XXX_local_link/", width = 12, height = 8)

### plot histogram of records to sites -----
site_year <- unique(temp_data[,c("site", "TP")])

# create and save the png plot
png(file = paste0("XXX_local_link/", identifier, "_", data_run, "_years_visited_by_site.png"))
hist(table(site_year$site), breaks = length(1970:max(dat$TP)), xlab = "number of years with visits", main = "") # used to be breaks = 53 - this is a histogram showing the number of years a site was recorded
dev.off() # Save the file.

### save data on number of sites recorded per year -----

# 1) number of grid cells recorded per year, raw, % of all surveyed, % of all UK 1km squares
total_surveyed <- length(unique(site_year$site)) # how many sites have a record
all_UK_cells <- length(unique(gb_recs[gb_recs$ENGLAND == 1 | gb_recs$SCOTLAND == 1 | gb_recs$WALES == 1 | gb_recs$NORTHERN_IRELAND == 1, "SQ1_SQUARE"])) # calulate total number of gird cells per country
year_recs_data <- data.frame(table(site_year$TP)) # create a dataframe of the number of records per year?
names(year_recs_data) <- c("year", "sites_visited")
year_recs_data$sites_visited_as_perc_all_visited <- (year_recs_data$sites_visited/total_surveyed)*100 # for each year calculate the % of all grid cells recorded in that given year compared to all that ever been visitsed for the given group
year_recs_data$sites_visited_as_perc_all_UK <- (year_recs_data$sites_visited/all_UK_cells)*100 # to the same but with compared to the total cells in the UK
write.csv(year_recs_data, file = paste0("XXX_local_link/", identifier, "_", data_run, "_sites_vis.csv"), row.names = FALSE) # save the file

# 2) extract the number of 1km grid cells with at least 10 years of data
site_years_visited <- data.frame(table(site_year$site))
names(site_years_visited) <- c("site", "years_visited")

sites_vis_txt <- paste0("For ", identifier, ", ", nrow(site_years_visited[site_years_visited$years_visited > 9,]), " 1km grid cells were visited in at least 10 years. This is ", 
                        (nrow(site_years_visited[site_years_visited$years_visited > 9,])/total_surveyed)*100, "% of all sites surveyed and ", 
                        (nrow(site_years_visited[site_years_visited$years_visited > 9,])/all_UK_cells)*100, "% of all uk 1km grid cells.")

write.table(sites_vis_txt, file = paste0("XXX_local_link/", identifier, "_", data_run, "_sites_with_10years_vis.txt"))



### prep the data for the occAssess plots -----
full_data <- data.frame(species = dat$variable, GRIDREF = dat$site, identifier = identifier, year = dat$TP)

new_spatial_data <- full_data
#new_spatial_data <- cbind(new_spatial_data, gr_let2num(new_spatial_data$GRIDREF))
#names(new_spatial_data) <- gsub("NORTHING", "y", names(new_spatial_data))
#names(new_spatial_data) <- gsub("EASTING", "x", names(new_spatial_data))
new_spatial_data <- cbind(new_spatial_data, gr2gps_latlon(new_spatial_data$GRIDREF)) # add lat long info
names(new_spatial_data) <- gsub("LATITUDE", "y", names(new_spatial_data))
names(new_spatial_data) <- gsub("LONGITUDE", "x", names(new_spatial_data))

new_spatial_data$year <- as.numeric(new_spatial_data$year)

# set spatial uncertainty 
new_spatial_data$spatialUncertainty <- 1000

### Plot the number of records per year (assessRecordNumber) -----
nrecs <- NULL
nrecs <- assessRecordNumber(dat = new_spatial_data, 
                            periods = periods,
                            species = "species",x = "x", 
                            y = "y", year = "year",
                            spatialUncertainty = "spatialUncertainty",
                            identifier = "identifier")

head(nrecs$data)
nrecs$data$YEAR <- unlist(periods) # add year column

clean_plot <- ggplot(data = nrecs$data, aes(y = val, x = YEAR,
                                            colour = group, 
                                            group = group)) + 
  geom_point() + 
  geom_line() + 
  theme_linedraw() + 
  ylab("Number of records") + 
  xlab("Year") + 
  labs(colour = "") +
  theme_bw() +
  ylim(0, max(nrecs$data$val)) +
  theme(legend.position="none")

clean_plot

ggsave(filename = paste(as.character(unique(new_spatial_data$identifier)), "_", data_run, "_taxa_rec.png", sep = ""), plot = clean_plot, path = "XXX_local_link/", width = 8, height = 5)

### Plot the number of species recorded per year (assessSpeciesNumber) -----
nSpec <- NULL
nSpec <- assessSpeciesNumber(dat = new_spatial_data, periods = periods,
                             species = "species",x = "x", 
                             y = "y", year = "year",
                             spatialUncertainty = "spatialUncertainty",
                             identifier = "identifier")

nSpec$data$YEAR <- unlist(periods) # add year column

nSpec_plot <- ggplot(data = nSpec$data, aes(y = val, x = YEAR,
                                            colour = group, 
                                            group = group)) + 
  geom_point() + 
  geom_line() + 
  theme_linedraw() + 
  ylab("Number of species recorded") + 
  xlab("Year") + 
  labs(colour = "") +
  theme_bw() +
  ylim(0, max(nSpec$data$val)) +
  theme(legend.position="none")

nSpec_plot

ggsave(filename = paste(as.character(unique(new_spatial_data$identifier)), "_", data_run, "_species_num.png", sep = ""), plot = nSpec_plot, path = "XXX_local_link/", width = 8, height = 5)

# save species recorded dataset
spp_recs_data <- nSpec$data
spp_recs_data$spp_rec_percent <- ((spp_recs_data$val)/length(unique(new_spatial_data$species)))*100
write.csv(spp_recs_data, file = paste0("XXX_local_link/", identifier, "_", data_run, "_species_recorded_per_year.csv"), row.names = FALSE)


### plot number of records per periods -----
library(maps)
library(rnaturalearth)
library(rnaturalearthdata)

# load the map
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

# create a dataframe (site by year) to fill 
survey_sites <- unique(new_spatial_data$GRIDREF)
site_period_matrix <- data.frame(GRIDREF = survey_sites, matrix(nrow = length(survey_sites), ncol = length(grouped_periods), data = 0))
names(site_period_matrix) <- gsub("X", "PERIOD", names(site_period_matrix))

# loop through time periods estimate number of time periods where we have records. Also extract the total number of visits per time period

my_plots <- list()

for (i in 1:length(grouped_periods)){
  period_data <- new_spatial_data[new_spatial_data$year %in% grouped_periods[[i]],]
  
  # plot period records
  to_plot <- unique(period_data[,c("GRIDREF", "y", "x")])
  
  period_map <- NULL
  
  period_map <- ggplot(data = world) +
    geom_sf() +
    geom_point(data = to_plot, aes(y = y, x = x), size=0.1) +
    coord_sf(xlim = c(-9, 2), ylim = c(48, 61), expand = FALSE) +
    theme_bw()
  
  my_plots[[i]] <- period_map
  
  # save the individual time period map
  ggsave(filename = paste(as.character(unique(new_spatial_data$identifier)), "_", data_run, "_TP", i, "_period_with_visits_map.png", sep = ""), plot = period_map, path = "XXX_local_link/", width = 11, height = 19)
  
  site_period_matrix[site_period_matrix$GRIDREF %in% unique(period_data$GRIDREF), paste0("PERIOD", i)] <- 1
}

# create a dataset with site and a count of how many periods it has has been recorded
site_period_matrix$num_periods_visited <- rowSums(site_period_matrix[,2:6]) # note 2:6 here is hard-coded. This should be the columns of data prefixed with "PERIOD".
site_period_matrix <- site_period_matrix[site_period_matrix$num_periods_visited>0,] # drop sites never visited

# save the combined map plot - so a panal plot one mapped period per plot panel = again my_plots[[X]] are hard-coded. It needs to be one per Period. 
p <- plot_grid(my_plots[[1]], my_plots[[2]], my_plots[[3]], my_plots[[4]], my_plots[[5]], labels = "AUTO")
save_plot(filename = paste0(identifier, "_", data_run, "_grouped_period_visit_plot.png"), 
          path = "XXX_local_link/", 
          plot = p,
          base_height = 12,
          bg = "white")


# add lat long back in
site_period_matrix <- cbind(site_period_matrix, gr2gps_latlon(site_period_matrix$GRIDREF))
names(site_period_matrix) <- gsub("LATITUDE", "y", names(site_period_matrix))
names(site_period_matrix) <- gsub("LONGITUDE", "x", names(site_period_matrix))

# Plot a single map, each grid cell is plotted and coloured based on the number of periods in which it was visited
visit_map <- ggplot(data = world) +
  geom_sf() +
  geom_point(data = site_period_matrix, aes(y = y, x = x, col = factor(num_periods_visited)), size=0.35) +
  coord_sf(xlim = c(-9, 2), ylim = c(48, 61), expand = FALSE) +
  theme_bw()

visit_map

ggsave(filename = paste(as.character(unique(new_spatial_data$identifier)), "_", data_run, "_periods_with_visits_map.png", sep = ""), plot = visit_map, path = "XXX_local_link/", width = 11, height = 19)

