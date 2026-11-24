### Create composite indicator for various custom functional groups ###
# APerson - 2024 #

rm(list=ls()) # clear R

require(TrendSummaries)
require(reshape2)
require(ggplot2)

# combine start clipped cleaned samp post datasets - manually load these.

# aquatic bugs
load("occupancy_model_summary/output/sampled_posterior/Aquatic_bugs_DPerson_2021_start_clipped_cleaned_rhat.rdata")
Aquatic_bugs_samp_post_start_clipped <- samp_post_start_clipped

# Bees
load("occupancy_model_summary/output/sampled_posterior/bees_monads_CPerson_2023_1km_start_clipped_cleaned_rhat.rdata")
Bees_samp_post_start_clipped <- samp_post_start_clipped
#Bees_samp_post_start_clipped <- Bees_samp_post_start_clipped[,-37] # drop 2022 year

# Ants
load("occupancy_model_summary/output/sampled_posterior/ants_monads_CPerson_2023_1km_start_clipped_cleaned_rhat.rdata")
Ants_samp_post_start_clipped <- samp_post_start_clipped
#Ants_samp_post_start_clipped <- Ants_samp_post_start_clipped[,-37] # drop 2022 year

# Wasps
load("occupancy_model_summary/output/sampled_posterior/wasps_monads_CPerson_2023_1km_start_clipped_cleaned_rhat.rdata")
Wasps_samp_post_start_clipped <- samp_post_start_clipped
#Wasps_samp_post_start_clipped <- Wasps_samp_post_start_clipped[,-37] # drop 2022 year

# Carabids
load("occupancy_model_summary/output/sampled_posterior/Carabids_CPerson_2022_start_clipped_cleaned_rhat.rdata")
Carabids_samp_post_start_clipped <- samp_post_start_clipped

# Cerambycidae
load("occupancy_model_summary/output/sampled_posterior/Cerambycidae_CPerson_2022_start_clipped_cleaned_rhat.rdata")
Cerambycidae_samp_post_start_clipped <- samp_post_start_clipped

# Craneflies
load("occupancy_model_summary/output/sampled_posterior/Craneflies_2022_CPerson_start_clipped_cleaned_rhat.rdata")
Craneflies_samp_post_start_clipped <- samp_post_start_clipped

# caddisflies
load("occupancy_model_summary/output/sampled_posterior/Trichoptera_DPerson_2021_start_clipped_cleaned_rhat.rdata")
Trichoptera_samp_post_start_clipped <- samp_post_start_clipped

# E and D
load("occupancy_model_summary/output/sampled_posterior/E_and_D_BPerson_2021_start_clipped_cleaned_rhat.rdata")
E_and_D_samp_post_start_clipped <- samp_post_start_clipped

# Fungus Gnats
load("occupancy_model_summary/output/sampled_posterior/Fungus_gnats_CPerson_2022_start_clipped_cleaned_rhat.rdata")
Fungus_gnats_samp_post_start_clipped <- samp_post_start_clipped

# Ladybirds
load("occupancy_model_summary/output/sampled_posterior/Ladybird_2022_CPerson_start_clipped_cleaned_rhat.rdata")
Ladybird_samp_post_start_clipped <- samp_post_start_clipped

# Lead seed beetles
load("occupancy_model_summary/output/sampled_posterior/Leafseed_beetles_CPerson_2023_start_clipped_cleaned_rhat.rdata")
Leafseed_beetles_samp_post_start_clipped <- samp_post_start_clipped

# Mayflies
load("occupancy_model_summary/output/sampled_posterior/Ephemeroptera_CPerson_2022_start_clipped_cleaned_rhat.rdata")
Ephemeroptera_samp_post_start_clipped <- samp_post_start_clipped

# Soldierflies
load("occupancy_model_summary/output/sampled_posterior/Soldierflies_CPerson_2022_start_clipped_cleaned_rhat.rdata")
Soldierflies_samp_post_start_clipped <- samp_post_start_clipped

# Shield bugs
load("occupancy_model_summary/output/sampled_posterior/Shieldbugs_CPerson_2022_start_clipped_cleaned_rhat.rdata")
Shieldbugs_samp_post_start_clipped <- samp_post_start_clipped

# Stoneflies
load("occupancy_model_summary/output/sampled_posterior/Plecoptera_2021_DPerson_start_clipped_cleaned_rhat.rdata")
Plecoptera_samp_post_start_clipped <- samp_post_start_clipped

# Orthoptera
load("occupancy_model_summary/output/sampled_posterior/Orthoptera_CPerson_2022_start_clipped_cleaned_rhat.rdata")
Orthoptera_samp_post_start_clipped <- samp_post_start_clipped

# odonata
load("occupancy_model_summary/output/sampled_posterior/Odonata_2022_APerson_start_clipped_cleaned_rhat.rdata")
odonata_samp_post_start_clipped <- samp_post_start_clipped

# hoverflies
load("occupancy_model_summary/output/sampled_posterior/Hoverflies_BPerson_2023_start_clipped_cleaned_rhat.rdata")
Hoverflies_samp_post_start_clipped <- samp_post_start_clipped

## save them for each grouping

# Freshwater
samp_post <- NULL
samp_post <- dplyr::bind_rows(odonata_samp_post_start_clipped, Aquatic_bugs_samp_post_start_clipped, Trichoptera_samp_post_start_clipped, Ephemeroptera_samp_post_start_clipped, Plecoptera_samp_post_start_clipped)
save(samp_post, file = "occupancy_model_summary/output/sampled_posterior/Freshwater_start_clipped_cleaned_rhat.rdata")

# All Insects
samp_post <- NULL
samp_post <- dplyr::bind_rows(odonata_samp_post_start_clipped, Aquatic_bugs_samp_post_start_clipped, Bees_samp_post_start_clipped, Ants_samp_post_start_clipped, Wasps_samp_post_start_clipped, Carabids_samp_post_start_clipped, Cerambycidae_samp_post_start_clipped, Craneflies_samp_post_start_clipped, 
                                            E_and_D_samp_post_start_clipped, Fungus_gnats_samp_post_start_clipped, Trichoptera_samp_post_start_clipped, Ladybird_samp_post_start_clipped, Leafseed_beetles_samp_post_start_clipped,
                                            Ephemeroptera_samp_post_start_clipped, Soldierflies_samp_post_start_clipped, Shieldbugs_samp_post_start_clipped, Plecoptera_samp_post_start_clipped, 
                                            Orthoptera_samp_post_start_clipped, Hoverflies_samp_post_start_clipped)

samp_post <- samp_post[,-length(samp_post)]

save(samp_post, file = "occupancy_model_summary/output/sampled_posterior/All_insect_start_clipped_cleaned_rhat.rdata")

# pest control species
samp_post <- NULL
samp_post <- dplyr::bind_rows(Carabids_samp_post_start_clipped, Ladybird_samp_post_start_clipped, odonata_samp_post_start_clipped, Ants_samp_post_start_clipped, Wasps_samp_post_start_clipped, Hoverflies_samp_post_start_clipped)
samp_post <- samp_post[,-length(samp_post)]

save(samp_post, file = "occupancy_model_summary/output/sampled_posterior/pest_control_start_clipped_cleaned_rhat.rdata")

# Key food resource
samp_post <- NULL
samp_post <- dplyr::bind_rows(Craneflies_samp_post_start_clipped, Trichoptera_samp_post_start_clipped, Ephemeroptera_samp_post_start_clipped, Plecoptera_samp_post_start_clipped, 
                                            Orthoptera_samp_post_start_clipped, odonata_samp_post_start_clipped)

save(samp_post, file = "occupancy_model_summary/output/sampled_posterior/key_food_start_clipped_cleaned_rhat.rdata")

# pollinators
samp_post <- NULL
samp_post <- dplyr::bind_rows(Hoverflies_samp_post_start_clipped, Bees_samp_post_start_clipped)

save(samp_post, file = "occupancy_model_summary/output/sampled_posterior/pollinators_start_clipped_cleaned_rhat.rdata")

# pollinators _ 1990 onwards
samp_post <- NULL
samp_post <- dplyr::bind_rows(Hoverflies_samp_post_start_clipped, Bees_samp_post_start_clipped)
samp_post <- samp_post[,21:length(names(samp_post))]

save(samp_post, file = "occupancy_model_summary/output/sampled_posterior/pollinators_1990_start_clipped_cleaned_rhat.rdata")


### Run the groups here
trendOutputs <- CompositeTrend(indata = "occupancy_model_summary/output/sampled_posterior/pest_control_start_clipped_cleaned_rhat.rdata",
                               output_path = "occupancy_model_summary/output/composite_trends/",
                               trend_choice = "arithmetic_logit_occ",
                               group_name = "pest_control_start_clipped_cleaned_rhat",
                               plot_output = TRUE)



### lambda indicator ###
# Array indicator with full cleaning #
samp_post <- NULL
samp_post_start_clipped <- NULL

# set group
group_run <- "pest_control_start_clipped_cleaned_rhat" # "All_insect_start_clipped_cleaned_rhat", "pest_control_start_clipped_cleaned_rhat", "pollinators_start_clipped_cleaned_rhat"

load(paste0("occupancy_model_summary/output/sampled_posterior/", group_run, ".rdata"))
samp_post_start_clipped <- samp_post

# convert samp_post_start_clipped to an array
spp_list <- unique(as.character(samp_post_start_clipped$species))

temp_array <- melt(samp_post_start_clipped, id.vars = c("species", "iteration"), variable.name = "year")
#rm(samp_post_start_clipped)
#gc()
temp_array$year <- gsub("year_", "", temp_array$year)
temp_array$year <- as.numeric(as.character(temp_array$year))
temp_array$value< - as.numeric(as.character(temp_array$value))

samp_array <- acast(temp_array, formula = species ~ year ~ iteration)
rm(temp_array)
gc()

temp_array_indicator <- BRCindicators::lambda_indicator(samp_array, upperQuantile = 0.95, lowerQuantile = 0.05, threshold_Rhat = Inf, threshold_sd = Inf, threshold_yrs = 10)

# plot raw occ lambda indicator and save data
write.csv(temp_array_indicator$summary, file = paste0("occupancy_model_summary/output/composite_trends/", group_run, "_array_lambda_ind.csv"), row.names = FALSE) # save the indicator table

# ggplot2 of the indicator
temp_array_plot <- BRCindicators::plot_indicator(temp_array_indicator$summary[,'indicator'], temp_array_indicator$summary[,c('lower' ,'upper')], year = temp_array_indicator$summary$year)
temp_array_plot <- temp_array_plot + theme_bw()
temp_array_plot

ggsave(temp_array_plot, filename = paste0(group_run, "_array_lambda_indicator.png"), path = "occupancy_model_summary/output/composite_trends/", width = 12, height = 8, dpi = 200)

# save species trends table
write.csv(temp_array_indicator$species_change, file = paste0("occupancy_model_summary/output/composite_trends/", group_run, "_array_lambda_species_trends.csv")) # save the species change estimates

