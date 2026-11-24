### Create Paper figures #1 (non-weighted) ###
# APerson - July 2023 #

rm(list=ls()) # clear R

# install packages
require(ggplot2)

## Functional group plots ##

# load data
key_food <- read.csv("occupancy_model_summary/output/composite_trends/key_food_start_clipped_cleaned_rhat_array_lambda_ind.csv")
pest_cont <- read.csv("occupancy_model_summary/output/composite_trends/pest_control_start_clipped_cleaned_rhat_array_lambda_ind.csv")
fwater <- read.csv("occupancy_model_summary/output/composite_trends/Freshwater_start_clipped_cleaned_rhat_array_lambda_ind.csv")
all_insect <- read.csv("occupancy_model_summary/output/composite_trends/All_insect_start_clipped_cleaned_rhat_array_lambda_ind.csv")
pollinator <- read.csv("occupancy_model_summary/output/composite_trends/pollinators_1990_start_clipped_cleaned_rhat_array_lambda_ind.csv")

# add group columns
key_food$group <- "Key food resource"
pest_cont$group <- "Pest control"
fwater$group <- "Freshwater"
all_insect$group <- "All insects"
pollinator$group <- "Pollinator"

# combine into plot data
plot_data <- rbind(key_food, pest_cont, fwater, all_insect, pollinator)

# combined plot
plot_data$group <- factor(plot_data$group)
plot_data <- plot_data[plot_data$year < 2022,]

# create functional group figure 
p1 <- ggplot(plot_data, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(aes_string(ymin = "lower", ymax = "upper", fill = "group"),
              alpha = 0.3, colour = NA) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  scale_colour_manual(values = c(
    "orchid3",
    "darkorange2",
    "skyblue2",
    "springgreen4",
    "dodgerblue4"
  )) +
  scale_fill_manual(values = c(
    "orchid3",
    "darkorange2",
    "skyblue2",
    "springgreen4",
    "dodgerblue4"
  )) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p1

ggsave(filename = "XXX_local_link/functional_composite_plots_col_blind.png", plot = p1, dpi = 300, height = 5, width = 7)


## Taxonomic group plots

## Freshwater groups

# load data
Mayflies <- read.csv("occupancy_model_summary/output/composite_trends/Ephemeroptera_CPerson_2022_start_clipped_array_lambda_ind.csv") # _start_clipped_array_lambda_ind has had rhat cleaned treatment... i.e. bad rhats converted to NA.
Aquatic_Bugs <- read.csv("occupancy_model_summary/output/composite_trends/Aquatic_bugs_DPerson_2021_start_clipped_array_lambda_ind.csv")
Dragonflies <- read.csv("occupancy_model_summary/output/composite_trends/Odonata_2022_APerson_start_clipped_array_lambda_ind.csv")
Stoneflies <- read.csv("occupancy_model_summary/output/composite_trends/Plecoptera_2021_DPerson_start_clipped_array_lambda_ind.csv")
Caddisflies <- read.csv("occupancy_model_summary/output/composite_trends/Trichoptera_DPerson_2021_start_clipped_array_lambda_ind.csv")

# add group columns
Mayflies$group <- "Mayflies"
Aquatic_Bugs$group <- "Aquatic Bugs"
Dragonflies$group <- "Dragonflies & Damselflies"
Stoneflies$group <- "Stoneflies"
Caddisflies$group <- "Caddisflies"

# create colour blind palette
cb_palette <- c(
  "Mayflies" = "#D55E00", # vermillion
  "Stoneflies" = "#0072B2", # blue
  "Caddisflies" = "#009E73", # bluish green
  "Dragonflies & Damselflies" = "#CC79A7", # reddish purple
  "Beetles" = "#E69F00", # orange
  "Aquatic Bugs" = "#56B4E9", # sky blue
  "Molluscs" = "#F0E442" # yellow
)

# combine into plot data
fw_plot_data_1 <- rbind(Mayflies, Stoneflies, Caddisflies)
fw_plot_data_2 <- rbind(Aquatic_Bugs, Dragonflies)

# create freshwater 1 groups figure 
p2 <- ggplot(fw_plot_data_1, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(
    aes_string(ymin = "lower", ymax = "upper", fill = "group"),
    alpha = 0.3,
    linetype = 0) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 250), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  scale_colour_manual(values = cb_palette) +
  scale_fill_manual(values = cb_palette) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.85),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p2

ggsave(filename = "XXX_local_link/riverfly_composite_plots_col_blind.png", plot = p2, dpi = 300, height = 5, width = 7)

# create freshwater 1 groups figure 
p3 <- ggplot(fw_plot_data_2, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(
    aes_string(ymin = "lower", ymax = "upper", fill = "group"),
    alpha = 0.3,
    linetype = 0) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 215), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  scale_colour_manual(values = cb_palette) +
  scale_fill_manual(values = cb_palette) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.85),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p3

ggsave(filename = "XXX_local_link/odonata_aqua_bugs_composite_plots_col_blind.png", plot = p3, dpi = 300, height = 5, width = 7)


## Terrestrial groups 1

# load data
Carabids <- read.csv("occupancy_model_summary/output/composite_trends/Carabids_CPerson_2022_start_clipped_array_lambda_ind.csv") # _start_clipped_array_lambda_ind has had rhat cleaned treatment... i.e. bad rhats converted to NA.
Ladybirds <- read.csv("occupancy_model_summary/output/composite_trends/Ladybird_2022_CPerson_start_clipped_array_lambda_ind.csv")
Leafseed_beetles <- read.csv("occupancy_model_summary/output/composite_trends/Leafseed_beetles_CPerson_2023_start_clipped_array_lambda_ind.csv")
Longhorns <- read.csv("occupancy_model_summary/output/composite_trends/Cerambycidae_CPerson_2022_start_clipped_array_lambda_ind.csv")

# add group columns
Carabids$group <- "Ground beetles"
Ladybirds$group <- "Ladybirds"
Leafseed_beetles$group <- "Leaf & seed beetles"
Longhorns$group <- "Longhorn beetles"

cb_palette <- c(
  "Ground beetles" = "#D55E00", # vermillion
  "Leaf & seed beetles" = "grey", # blue
  "Longhorn beetles" = "#002E73", # bluish green
  "Ladybirds" = "#CC79A7", # reddish purple
  "Beetles" = "#E69F00", # orange
  "Aquatic Bugs" = "#56B4E9" # sky blue
)

# combine into plot data
terra_plot_data_1 <- rbind(Carabids, Ladybirds, Leafseed_beetles, Longhorns)


# create freshwater 1 groups figure 
p4 <- ggplot(terra_plot_data_1, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(
    aes_string(ymin = "lower", ymax = "upper", fill = "group"),
    alpha = 0.3,
    linetype = 0) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 180), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  #scale_colour_manual(values = cb_palette) +
  #scale_fill_manual(values = cb_palette) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.85),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p4

ggsave(filename = "XXX_local_link/beetle_composite_plots.png", plot = p4, dpi = 300, height = 5, width = 7)


## Terrestrial groups 2

# load data
Craneflies <- read.csv("occupancy_model_summary/output/composite_trends/Craneflies_2022_CPerson_start_clipped_array_lambda_ind.csv") # _start_clipped_array_lambda_ind has had rhat cleaned treatment... i.e. bad rhats converted to NA.
E_and_D <- read.csv("occupancy_model_summary/output/composite_trends/E_and_D_BPerson_2021_start_clipped_array_lambda_ind.csv")
Fungus_gnats <- read.csv("occupancy_model_summary/output/composite_trends/Fungus_gnats_CPerson_2022_start_clipped_array_lambda_ind.csv")
Soldierflies <- read.csv("occupancy_model_summary/output/composite_trends/Soldierflies_CPerson_2022_start_clipped_array_lambda_ind.csv")
Hoverflies <- read.csv("occupancy_model_summary/output/composite_trends/Hoverflies_BPerson_2023_start_clipped_array_lambda_ind.csv")

cb_palette <- c(
  "Craneflies" = "darkgrey", # vermillion
  "Empid & Dolichopodid Flies" = "#56B4E9", # blue
  "Hoverflies" = "#002E73", # bluish green
  "Soldierflies" = "#CC79A7", # reddish purple
  "Fungus gnats" = "#E69F00", # orange
  "Aquatic Bugs" = "#" # sky blue
)


# add group columns
Craneflies$group <- "Craneflies"
E_and_D$group <- "Empid & Dolichopodid Flies"
Fungus_gnats$group <- "Fungus gnats"
Soldierflies$group <- "Soldierflies"
Hoverflies$group <- "Hoverflies"

# combine into plot data
terra_plot_data_2 <- rbind(Craneflies, E_and_D, Fungus_gnats, Soldierflies, Hoverflies)

# create terrestrial 2 groups figure 
p5 <- ggplot(terra_plot_data_2, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(
    aes_string(ymin = "lower", ymax = "upper", fill = "group"),
    alpha = 0.3,
    linetype = 0) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 250), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  scale_colour_manual(values = cb_palette) +
  scale_fill_manual(values = cb_palette) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.82),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p5

ggsave(filename = "XXX_local_link/flies_composite_plots_col_blind.png", plot = p5, dpi = 300, height = 5, width = 7)

## Terrestrial groups 3

# load data
Orthoptera <- read.csv("occupancy_model_summary/output/composite_trends/Orthoptera_CPerson_2022_start_clipped_array_lambda_ind.csv") # _start_clipped_array_lambda_ind has had rhat cleaned treatment... i.e. bad rhats converted to NA.
Shieldbugs <- read.csv("occupancy_model_summary/output/composite_trends/Shieldbugs_CPerson_2022_start_clipped_array_lambda_ind.csv")

# add group columns
Orthoptera$group <- "Orthoptera"
Shieldbugs$group <- "Shieldbugs"

# combine into plot data
terra_plot_data_3 <- rbind(Orthoptera, Shieldbugs)

# create freshwater 1 groups figure 
p6 <- ggplot(terra_plot_data_3, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(
    aes_string(ymin = "lower", ymax = "upper", fill = "group"),
    alpha = 0.3,
    linetype = 0) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 200), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  scale_colour_manual(values = cb_palette) +
  scale_fill_manual(values = cb_palette) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p6

ggsave(filename = "XXX_local_link/other_insects_composite_plots.png", plot = p6, dpi = 300, height = 5, width = 7)

## Terrestrial groups 4

# load data
Bees <- read.csv("occupancy_model_summary/output/composite_trends/bee_CPerson_2023_1km_start_clipped_array_lambda_ind.csv") # _start_clipped_array_lambda_ind has had rhat cleaned treatment... i.e. bad rhats converted to NA.
Wasps <- read.csv("occupancy_model_summary/output/composite_trends/wasp_CPerson_2023_1km_start_clipped_array_lambda_ind.csv")
Ants <- read.csv("occupancy_model_summary/output/composite_trends/ant_CPerson_2023_1km_start_clipped_array_lambda_ind.csv")

cb_palette <- c(
  "Bees" = "darkgrey", # vermillion
  "Wasps" = "#002E73", # bluish green
  "Ants" = "#E69F00" # orange
)

# add group columns
Bees$group <- "Bees"
Wasps$group <- "Wasps"
Ants$group <- "Ants"

# combine into plot data
terra_plot_data_4 <- rbind(Bees, Wasps, Ants)
terra_plot_data_4 <- terra_plot_data_4[terra_plot_data_4$year < 2022,]

# create freshwater 1 groups figure 
p7 <- ggplot(terra_plot_data_4, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(
    aes_string(ymin = "lower", ymax = "upper", fill = "group"),
    alpha = 0.3,
    linetype = 0) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1986 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 180), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1985, 2022), expand = c(0, 0)) +
  scale_colour_manual(values = cb_palette) +
  scale_fill_manual(values = cb_palette) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.85),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p7

ggsave(filename = "XXX_local_link/bees_wasps_ants_composite_plots.png", plot = p7, dpi = 300, height = 5, width = 7)


## Terrestrial groups 4 - bwars with refined inferred absence (by group within bwars)

# load data
Bees <- read.csv("occupancy_model_summary/output/composite_trends/bees_monads_CPerson_2023_1km_start_clipped_array_lambda_ind.csv") # _start_clipped_array_lambda_ind has had rhat cleaned treatment... i.e. bad rhats converted to NA.
Wasps <- read.csv("occupancy_model_summary/output/composite_trends/wasps_monads_CPerson_2023_1km_start_clipped_array_lambda_ind.csv")
Ants <- read.csv("occupancy_model_summary/output/composite_trends/ants_monads_CPerson_2023_1km_start_clipped_array_lambda_ind.csv")

# add group columns
Bees$group <- "Bees"
Wasps$group <- "Wasps"
Ants$group <- "Ants"


cb_palette <- c(
  "Bees" = "darkgreen", # vermillion
  "Wasps" = "#002E73", # bluish green
  "Ants" = "#E69F00" # orange
)


# combine into plot data
terra_plot_data_5 <- rbind(Bees, Wasps, Ants)
terra_plot_data_5 <- terra_plot_data_5[terra_plot_data_5$year < 2022,]
terra_plot_data_5 <- na.omit(terra_plot_data_5)


# create terrestrial group 5 figure 
p8 <- ggplot(terra_plot_data_5, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(
    aes_string(ymin = "lower", ymax = "upper", fill = "group"),
    alpha = 0.3,
    linetype = 0) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1986 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 180), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1985, 2021), expand = c(0, 0)) +
  scale_colour_manual(values = cb_palette) +
  scale_fill_manual(values = cb_palette) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.85),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p8

ggsave(filename = "XXX_local_link/bees_wasps_ants_refined_abs_composite_plots.png", plot = p8, dpi = 300, height = 5, width = 7)


all_groups_data <- rbind(plot_data[plot_data$year > 2017,], 
                         fw_plot_data_1[fw_plot_data_1$year > 2017,], 
                         fw_plot_data_2[fw_plot_data_2$year > 2017,], 
                         terra_plot_data_1[terra_plot_data_1$year > 2017,], 
                         terra_plot_data_2[terra_plot_data_2$year > 2017,],
                         terra_plot_data_3[terra_plot_data_3$year > 2017,],
                         terra_plot_data_5[terra_plot_data_5$year > 2017,])

write.csv(all_groups_data, file = "XXX_local_link/group_indicator_final_values.csv", row.names = FALSE) # save the indicator table

