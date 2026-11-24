### Create composite indicator for various taxonomic groups ###
# APerson - 2024

rm(list=ls()) # clear R

require(TrendSummaries)
require(reshape2)
require(ggplot2)

# combine start clipped cleaned samp post datasets

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
samp_post <- samp_post[,21:length(names(samp_post))] # drop years prior to 1990
samp_post <- samp_post[,!names(samp_post) %in% "year_2022"] # drop 2022 year

save(samp_post, file = "occupancy_model_summary/output/sampled_posterior/pollinators_1990_start_clipped_cleaned_rhat.rdata")

### lambda indicator ###
# Array indicator with full cleaning #
samp_post <- NULL
samp_post_start_clipped <- NULL

# set group
group_run <- "pollinators_1990_start_clipped_cleaned_rhat" # "All_insect_start_clipped_cleaned_rhat", "key_food_start_clipped_cleaned_rhat", "pollinators_start_clipped_cleaned_rhat", "Freshwater_start_clipped_cleaned_rhat", pollinators_1990_start_clipped_cleaned_rhat, pest_control_start_clipped_cleaned_rhat

# Set Weighting
#weighting_setting <- "og_risk_score"
weighting_setting <- "exp_sp_env"

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

# add functional weighting score
if (weighting_setting == "og_risk_score"){
  All_Insect_rs_over<- read.csv("occupancy_model_summary/output/All_Insect_weighted_risk_score_overview.csv", header = TRUE)
  All_Insect_spp_weights <- read.csv("occupancy_model_summary/output/All_Insect_species_weighted_risk_score_overview.csv", header = TRUE)
  pest_control_rs_over<- read.csv("occupancy_model_summary/output/pest_control_weighted_risk_score_overview.csv", header = TRUE)
  pest_control_spp_weights <- read.csv("occupancy_model_summary/output/pest_control_species_weighted_risk_score_overview.csv", header = TRUE)
  pollinators_rs_over<- read.csv("occupancy_model_summary/output/pollinators_weighted_risk_score_overview.csv", header = TRUE)
  pollinators_spp_weights <- read.csv("occupancy_model_summary/output/pollinators_species_weighted_risk_score_overview.csv", header = TRUE)
  Key_food_resource_rs_over<- read.csv("occupancy_model_summary/output/Key food resource_weighted_risk_score_overview.csv", header = TRUE)
  Key_food_resource_spp_weights <- read.csv("occupancy_model_summary/output/Key food resource_species_weighted_risk_score_overview.csv", header = TRUE)
  freshwater_rs_over<- read.csv("occupancy_model_summary/output/freshwater_weighted_risk_score_overview.csv", header = TRUE)
  freshwater_spp_weights <- read.csv("occupancy_model_summary/output/freshwater_species_weighted_risk_score_overview.csv", header = TRUE)
}

if (weighting_setting == "exp_sp_env"){
  All_Insect_rs_over<- read.csv("occupancy_model_summary/output/All_insect_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  All_Insect_spp_weights <- read.csv("occupancy_model_summary/output/All_insect_species_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  pest_control_rs_over<- read.csv("occupancy_model_summary/output/pest_control_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  pest_control_spp_weights <- read.csv("occupancy_model_summary/output/pest_control_species_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  pollinators_rs_over<- read.csv("occupancy_model_summary/output/pollinators_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  pollinators_spp_weights <- read.csv("occupancy_model_summary/output/pollinators_species_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  Key_food_resource_rs_over<- read.csv("occupancy_model_summary/output/Key food resource_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  Key_food_resource_spp_weights <- read.csv("occupancy_model_summary/output/Key food resource_species_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  freshwater_rs_over<- read.csv("occupancy_model_summary/output/freshwater_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
  freshwater_spp_weights <- read.csv("occupancy_model_summary/output/freshwater_species_weighted_risk_score_overview_spat_environ.csv", header = TRUE)
}

###-- Select rs over and weights here --###
rs_over <- pollinators_rs_over
spp_weights <- pollinators_spp_weights

# TEMP ADD
index = 100
sample_size = NULL
year_range = NULL
region = NULL
upperQuantile = 0.95
lowerQuantile = 0.05
threshold_Rhat = Inf
threshold_sd = Inf
threshold_yrs = 10
input <- samp_array

# weighted mean function 
weighted_mean <- function(x, w, na.rm = TRUE) {
  # Handle NA values if na.rm is TRUE
  if (na.rm) {
    valid <- !is.na(x)
    x <- x[valid]
    w <- w[valid]
  }
  # Calculate weighted mean
  if (sum(w) != 0) {
    sum(w * x) / sum(w)
  } else {
    NA  # Return NA if the sum of weights is zero
  }
}

### custom indicator ###
custom_lambda_indicator <- function (input, index = 100, threshold_sd = 0.2, threshold_Rhat = 1.1, 
          threshold_yrs = 20, upperQuantile = 0.975, lowerQuantile = 0.025, 
          sample_size = NULL, year_range = NULL, region = NULL) 
{
  Occ <-  BRCindicators:::getData(input = input, sample_size = sample_size, 
                 region = region)
  if (!is.null(year_range)) 
    Occ <- subset_years(Occ, year_range)
  nsp1 <- dim(Occ)[1]
  Occ <- BRCindicators:::remove_bad_species(Occ = Occ, threshold_sd = threshold_sd, 
                            threshold_yrs = threshold_yrs, threshold_Rhat = threshold_Rhat)
  good_years <- attr(Occ, "good_years")
  nsp2 <- dim(Occ)[1]
  if (dim(Occ)[1] == 0) {
    stop("No species meet the threshold criteria")
  } else if ((nsp1 - nsp2) > 0) {
    message(paste(nsp1 - nsp2, "Species have been removed as they don't meet your thresholds"))
  }
  Occ <- car::logit(Occ, adjust = 0.001)
  LogLambda <- apply(Occ, c(1, 3), BRCindicators:::lambda_calc)
  LogLambda <- aperm(LogLambda, c(2, 1, 3))
  for (i in 1:nrow(LogLambda)) {
    firstZero <- match(0, LogLambda[i, , ])
    LogLambda[i, firstZero, ] <- NA
  }
  dimnames(LogLambda) <- dimnames(Occ)
  
  # create the weighting vector
  weighting_dataframe <- data.frame("species" = row.names(LogLambda[,,1]))
  weighting_dataframe <- merge(weighting_dataframe, spp_weights, all.x = TRUE)
  weighting_vector <- weighting_dataframe$normalized_inverse_weights 
  
  # Apply weighted mean calculation across the specified dimensions
  Delta <- apply(LogLambda, c(2, 3), function(x) weighted_mean(x, weighting_vector, na.rm = TRUE))
  # old_Delta <- apply(LogLambda, c(2, 3), mean, na.rm = T)
  
  Delta[1, ] <- 0
  Theta <- matrix(data = NA, nrow = nrow(Delta), ncol = ncol(Delta), 
                  dimnames = dimnames(Delta))
  Theta[!is.na(rowMeans(Delta)), ] <- apply(Delta[!is.na(rowMeans(Delta)), 
  ], 2, cumsum)
  Lambda <- exp(Theta)
  Indicator_data <- index * Lambda
  indicator <- apply(Indicator_data, 1, mean)
  Indicator_CI <- t(apply(Indicator_data, 1, quantile, probs = c(lowerQuantile, 
                                                                 upperQuantile), na.rm = TRUE))
  colnames(Indicator_CI) <- c("lower", "upper")
  summary_table <- as.data.frame(cbind(indicator, Indicator_CI))
  summary_table$year <- as.numeric(row.names(summary_table))
  if (any(is.na(summary_table))) 
    warning("Data not available for all years in output due to threshold data removal")
  sp_change <- BRCindicators:::species_assessment(LogLambda, start_year = min(as.numeric(dimnames(LogLambda)[[2]])) + 
                                    1, end_year = max(as.numeric(dimnames(LogLambda)[[2]])))
  LogLambdaPart <- LogLambda[, , 1]
  LogLambdaPartTF <- (!(is.na(LogLambdaPart)))
  NperYear <- colSums(LogLambdaPartTF)
  summary_table$Species_Number <- NperYear
  return(list(summary = summary_table, LogLambda = LogLambda, 
              ind_data = Indicator_data, species_change = sp_change, 
              good_years = good_years))
}


temp_array_indicator <- custom_lambda_indicator(samp_array, upperQuantile = 0.95, lowerQuantile = 0.05, threshold_Rhat = Inf, threshold_sd = Inf, threshold_yrs = 10)

# plot raw occ lambda indicator and save data
write.csv(temp_array_indicator$summary, file = paste0("occupancy_model_summary/output/composite_trends/", group_run, "_weighted_array_lambda_ind_", weighting_setting, ".csv"), row.names = FALSE) # save the indicator table

# ggplot2 of the indicator
temp_array_plot <- BRCindicators::plot_indicator(temp_array_indicator$summary[,'indicator'], temp_array_indicator$summary[,c('lower' ,'upper')], year = temp_array_indicator$summary$year)
temp_array_plot <- temp_array_plot + theme_bw()
temp_array_plot

ggsave(temp_array_plot, filename = paste0(group_run, "_weighted_", weighting_setting, "_array_lambda_indicator.png"), path = "occupancy_model_summary/output/composite_trends/", width = 12, height = 8, dpi = 200)

# save species trends table
write.csv(temp_array_indicator$species_change, file = paste0("occupancy_model_summary/output/composite_trends/", group_run, "_weighted_", weighting_setting, "_array_lambda_species_trends.csv")) # save the species change estimates

