### create the weighting vector ###
# APerson - Aug 2024 #

rm(list=ls()) # clear R

# for each taxononmic group, load the min max file, extract the species list and add a field contain the risk score.

# load min max files
aquatic_bugs <- read.csv("occupancy_model_summary/output/min_max_year/aquatic_bugs_20210219.csv", header = TRUE) 
aquatic_bugs$group <- "aquatic_bugs"
aquatic_bugs <- aquatic_bugs[,c("species", "group")]

ground_beetles <- read.csv("occupancy_model_summary/output/min_max_year/Carabidae_20221004.csv", header = TRUE)
ground_beetles$group <- "ground_beetles"
ground_beetles <- ground_beetles[,c("species", "group")]

longhorn_beetles <- read.csv("occupancy_model_summary/output/min_max_year/Cerambycidae_20221006.csv", header = TRUE)
longhorn_beetles$group <- "longhorn_beetles"
longhorn_beetles <- longhorn_beetles[,c("species", "group")]

craneflies <- read.csv("occupancy_model_summary/output/min_max_year/Craneflies_20220321.csv", header = TRUE)
craneflies$group <- "craneflies"
craneflies <- craneflies[,c("species", "group")]

e_and_d <- read.csv("occupancy_model_summary/output/min_max_year/E_and_D_20212604.csv", header = TRUE)
e_and_d$group <- "e_and_d"
e_and_d <- e_and_d[,c("species", "group")]

mayflies <- read.csv("occupancy_model_summary/output/min_max_year/Ephemeroptera_20221117.csv", header = TRUE)
mayflies$group <- "mayflies"
mayflies <- mayflies[,c("species", "group")]

fungus_gnats <- read.csv("occupancy_model_summary/output/min_max_year/FungusGnats_20221028.csv", header = TRUE)
fungus_gnats$group <- "fungus_gnats"
fungus_gnats <- fungus_gnats[,c("species", "group")]

hoverflies <- read.csv("occupancy_model_summary/output/min_max_year/Hoverflies_BPerson_2023.csv", header = TRUE)
hoverflies$group <- "hoverflies"
hoverflies <- hoverflies[,c("species", "group")]

ladybirds <- read.csv("occupancy_model_summary/output/min_max_year/Ladybirds_20220804.csv", header = TRUE)
ladybirds$group <- "ladybirds"
ladybirds <- ladybirds[,c("species", "group")]

leaf_seed_beetles <- read.csv("occupancy_model_summary/output/min_max_year/LeafSeedBeetle_190411.csv", header = TRUE)
leaf_seed_beetles$group <- "leaf_seed_beetles"
leaf_seed_beetles <- leaf_seed_beetles[,c("species", "group")]

odonata <- read.csv("occupancy_model_summary/output/min_max_year/Odonata_2022.csv", header = TRUE)
odonata$group <- "odonata"
odonata <- odonata[,c("species", "group")]

orthoptera <- read.csv("occupancy_model_summary/output/min_max_year/Orthoptera_20221020.csv", header = TRUE)
orthoptera$group <- "orthoptera"
orthoptera <- orthoptera[,c("species", "group")]

shieldbugs <- read.csv("occupancy_model_summary/output/min_max_year/Shieldbugs_20220725.csv", header = TRUE)
shieldbugs$group <- "shieldbugs"
shieldbugs <- shieldbugs[,c("species", "group")]

soldierflies <- read.csv("occupancy_model_summary/output/min_max_year/Soldierflies_20220321.csv", header = TRUE)
soldierflies$group <- "soldierflies"
soldierflies <- soldierflies[,c("species", "group")]

stoneflies <- read.csv("occupancy_model_summary/output/min_max_year/stoneflies_2021.csv", header = TRUE)
stoneflies$group <- "stoneflies"
stoneflies <- stoneflies[,c("species", "group")]

trichoptera <- read.csv("occupancy_model_summary/output/min_max_year/Trichoptera_2021.csv", header = TRUE)
trichoptera$group <- "trichoptera"
trichoptera <- trichoptera[,c("species", "group")]

# bwars names
BWARS_names <- read.csv("XXX_local_link/BWARS_2023_Nomenclature_with_group.csv", header = TRUE)
BWARS_names$species <- paste0("tik_", BWARS_names$tik)
BWARS <- BWARS_names[,c("species", "group")]

rm(BWARS_names)

stacked_df <- do.call(rbind, lapply(ls(), get))

# load weighted risk score
rs_over <- read.csv("occupancy_model_summary/output/risk_score_overview.csv", header = TRUE)
rs_over$inverse_weights <- 1 / rs_over$risk_score

# Normalize weights so they sum to 1
rs_over$normalized_inverse_weights <- rs_over$inverse_weights / sum(rs_over$inverse_weights)

# set lowest risk to 1
rs_over$risk_score_1 <- rs_over$risk_score/10
rs_over$inverse_weights_1 <- 1 / rs_over$risk_score_1

# match group names to the species data
rs_over$group <- gsub("Dragonflies & damselflies", "odonata", rs_over$group)
rs_over$group <- gsub("Hoverflies", "hoverflies", rs_over$group)
rs_over$group <- gsub("Bees", "bee", rs_over$group)
rs_over$group <- gsub("Wasps", "wasp", rs_over$group)
rs_over$group <- gsub("Caddisflies", "trichoptera", rs_over$group)
rs_over$group <- gsub("Mayflies", "mayflies", rs_over$group)
rs_over$group <- gsub("Longhorn beetles", "longhorn_beetles", rs_over$group)
rs_over$group <- gsub("Ants", "ant", rs_over$group)
rs_over$group <- gsub("Grasshoppers & crickets", "orthoptera", rs_over$group)
rs_over$group <- gsub("Soldierflies", "soldierflies", rs_over$group)
rs_over$group <- gsub("Ground beetles", "ground_beetles", rs_over$group)
rs_over$group <- gsub("Ladybirds", "ladybirds", rs_over$group)
rs_over$group <- gsub("Craneflies", "craneflies", rs_over$group)
rs_over$group <- gsub("Shieldbugs", "shieldbugs", rs_over$group)
rs_over$group <- gsub("Fungus gnats", "fungus_gnats", rs_over$group)
rs_over$group <- gsub("Leaf & seed beetles", "leaf_seed_beetles", rs_over$group)
rs_over$group <- gsub("Stoneflies", "stoneflies", rs_over$group)
rs_over$group <- gsub("Empid & dolichopodid flies", "e_and_d", rs_over$group)
rs_over$group <- gsub("Aquatic bugs", "aquatic_bugs", rs_over$group)

# "All_insect_start_clipped_cleaned_rhat"

# save the weight scores across all species
write.csv(rs_over, file = "occupancy_model_summary/output/All_insect_weighted_risk_score_overview.csv", row.names = FALSE)

# join species info to weights
spp_weights <- merge(stacked_df, rs_over, all.x = TRUE)

# save the weight scores per species
write.csv(spp_weights, file = "occupancy_model_summary/output/All_insect_species_weighted_risk_score_overview.csv", row.names = FALSE)


# "pest_control" 
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("ground_beetles", "ladybirds", "odonata", "ant", "wasp", "hoverflies"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/pest_control_weighted_risk_score_overview.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/pest_control_species_weighted_risk_score_overview.csv", row.names = FALSE)


# "Key food resource"
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("craneflies", "trichoptera", "mayflies", "stoneflies", "orthoptera", "odonata"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/Key food resource_weighted_risk_score_overview.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/Key food resource_species_weighted_risk_score_overview.csv", row.names = FALSE)


# "pollinators"
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("bee", "hoverflies"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/pollinators_weighted_risk_score_overview.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/pollinators_species_weighted_risk_score_overview.csv", row.names = FALSE)


# "Freshwater"
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("odonata", "aquatic_bugs", "trichoptera", "mayflies", "stoneflies"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/freshwater_weighted_risk_score_overview.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/freshwater_species_weighted_risk_score_overview.csv", row.names = FALSE)



### load weighted risk score based only on spatial and environment
rs_over <- read.csv("occupancy_model_summary/output/risk_score_spatial_env_overview.csv", header = TRUE)
rs_over$risk_score <- exp(rs_over$risk_score)
rs_over$inverse_weights <- 1 / rs_over$risk_score

# Normalize weights so they sum to 1
rs_over$normalized_inverse_weights <- rs_over$inverse_weights / sum(rs_over$inverse_weights)

# match group names to the species data
rs_over$group <- gsub("Dragonflies & damselflies", "odonata", rs_over$group)
rs_over$group <- gsub("Hoverflies", "hoverflies", rs_over$group)
rs_over$group <- gsub("Bees", "bee", rs_over$group)
rs_over$group <- gsub("Wasps", "wasp", rs_over$group)
rs_over$group <- gsub("Caddisflies", "trichoptera", rs_over$group)
rs_over$group <- gsub("Mayflies", "mayflies", rs_over$group)
rs_over$group <- gsub("Longhorn beetles", "longhorn_beetles", rs_over$group)
rs_over$group <- gsub("Ants", "ant", rs_over$group)
rs_over$group <- gsub("Grasshoppers & crickets", "orthoptera", rs_over$group)
rs_over$group <- gsub("Soldierflies", "soldierflies", rs_over$group)
rs_over$group <- gsub("Ground beetles", "ground_beetles", rs_over$group)
rs_over$group <- gsub("Ladybirds", "ladybirds", rs_over$group)
rs_over$group <- gsub("Craneflies", "craneflies", rs_over$group)
rs_over$group <- gsub("Shieldbugs", "shieldbugs", rs_over$group)
rs_over$group <- gsub("Fungus gnats", "fungus_gnats", rs_over$group)
rs_over$group <- gsub("Leaf & seed beetles", "leaf_seed_beetles", rs_over$group)
rs_over$group <- gsub("Stoneflies", "stoneflies", rs_over$group)
rs_over$group <- gsub("Empid & dolichopodid flies", "e_and_d", rs_over$group)
rs_over$group <- gsub("Aquatic bugs", "aquatic_bugs", rs_over$group)

# "All_insect_start_clipped_cleaned_rhat"

# save the weight scores across all species
write.csv(rs_over, file = "occupancy_model_summary/output/All_insect_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)

# join species info to weights
spp_weights <- merge(stacked_df, rs_over, all.x = TRUE)

# save the weight scores per species
write.csv(spp_weights, file = "occupancy_model_summary/output/All_insect_species_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)


# "pest_control" 
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("ground_beetles", "ladybirds", "odonata", "ant", "wasp", "hoverflies"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/pest_control_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/pest_control_species_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)


# "Key food resource"
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("craneflies", "trichoptera", "mayflies", "stoneflies", "orthoptera", "odonata"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/Key food resource_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/Key food resource_species_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)


# "pollinators"
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("bee", "hoverflies"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/pollinators_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/pollinators_species_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)


# "Freshwater"
# select relevant species groups
fg_rs_over <- rs_over[rs_over$group %in% c("odonata", "aquatic_bugs", "trichoptera", "mayflies", "stoneflies"),]

# Normalize weights so they sum to 1
fg_rs_over$normalized_inverse_weights <- fg_rs_over$inverse_weights / sum(fg_rs_over$inverse_weights)

# save the weight scores across fg species
write.csv(fg_rs_over, file = "occupancy_model_summary/output/freshwater_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)

# join species info to weights
fg_spp_weights <- merge(stacked_df, fg_rs_over)

# save the weight scores per species
write.csv(fg_spp_weights, file = "occupancy_model_summary/output/freshwater_species_weighted_risk_score_overview_spat_environ.csv", row.names = FALSE)

