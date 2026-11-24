### Create paper figures - weighting adjusted functional group plot ###
# APerson - July 2023 #

rm(list=ls()) # clear R

# install packages
require(ggplot2)

## Functional group plots ##

# select weighting choice
weighting_setting <- "exp_sp_env" # og_risk_score or exp_sp_env

# load data
if(weighting_setting == "og_risk_score"){
  key_food <- read.csv("occupancy_model_summary/output/composite_trends/key_food_start_clipped_cleaned_rhat_weighted_array_lambda_ind.csv")
  pest_cont <- read.csv("occupancy_model_summary/output/composite_trends/pest_control_start_clipped_cleaned_rhat_weighted_array_lambda_ind.csv")
  fwater <- read.csv("occupancy_model_summary/output/composite_trends/Freshwater_start_clipped_cleaned_rhat_weighted_array_lambda_ind.csv")
  all_insect <- read.csv("occupancy_model_summary/output/composite_trends/All_insect_start_clipped_cleaned_rhat_weighted_array_lambda_ind.csv")
  pollinator <- read.csv("occupancy_model_summary/output/composite_trends/pollinators_1990_start_clipped_cleaned_rhat_weighted_array_lambda_ind.csv")
}

if(weighting_setting == "exp_sp_env"){
  key_food <- read.csv("occupancy_model_summary/output/composite_trends/key_food_start_clipped_cleaned_rhat_weighted_array_lambda_ind_exp_sp_env.csv")
  pest_cont <- read.csv("occupancy_model_summary/output/composite_trends/pest_control_start_clipped_cleaned_rhat_weighted_array_lambda_ind_exp_sp_env.csv")
  fwater <- read.csv("occupancy_model_summary/output/composite_trends/Freshwater_start_clipped_cleaned_rhat_weighted_array_lambda_ind_exp_sp_env.csv")
  all_insect <- read.csv("occupancy_model_summary/output/composite_trends/All_insect_start_clipped_cleaned_rhat_weighted_array_lambda_ind_exp_sp_env.csv")
  pollinator <- read.csv("occupancy_model_summary/output/composite_trends/pollinators_1990_start_clipped_cleaned_rhat_weighted_array_lambda_ind_exp_sp_env.csv")
}

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
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p1

ggsave(filename = paste0("XXX_local_link/weighted_functional_composite_plots_", weighting_setting,"_col_blind.png"), plot = p1, dpi = 300, height = 5, width = 7)


# plot trends on same plot

# load unweighted
key_food_un <- read.csv("occupancy_model_summary/output/composite_trends/key_food_start_clipped_cleaned_rhat_array_lambda_ind.csv")
pest_cont_un <- read.csv("occupancy_model_summary/output/composite_trends/pest_control_start_clipped_cleaned_rhat_array_lambda_ind.csv")
fwater_un <- read.csv("occupancy_model_summary/output/composite_trends/Freshwater_start_clipped_cleaned_rhat_array_lambda_ind.csv")
all_insect_un <- read.csv("occupancy_model_summary/output/composite_trends/All_insect_start_clipped_cleaned_rhat_array_lambda_ind.csv")
pollinator_un <- read.csv("occupancy_model_summary/output/composite_trends/pollinators_1990_start_clipped_cleaned_rhat_array_lambda_ind.csv")

# add group columns
key_food_un$group <- "Key food resource_un"
pest_cont_un$group <- "Pest control_un"
fwater_un$group <- "Freshwater_un"
all_insect_un$group <- "All insects_un"
pollinator_un$group <- "Pollinator_un"

# combine into plot data
combi_plot_data <- rbind(plot_data, key_food_un, pest_cont_un, fwater_un, all_insect_un, pollinator_un)

# combined plot
combi_plot_data$group <- factor(combi_plot_data$group)
combi_plot_data <- combi_plot_data[combi_plot_data$year < 2022,]

# create functional group figure 
p2 <- ggplot(combi_plot_data, aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(aes_string(ymin = "lower", ymax = "upper", fill = "group"),
              alpha = 0.3, colour = NA) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

p2

### individual function plots ###

# All species
# create functional group figure 
all_insect_trend_comp <- ggplot(combi_plot_data[combi_plot_data$group %in% c("All insects", "All insects_un"),], aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(aes_string(ymin = "lower", ymax = "upper", fill = "group"),
              alpha = 0.3, colour = NA) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  scale_colour_discrete(
    labels = c(
      "All insects" = "All insects",
      "All insects_un" = "All insects unweighted"
    )
  ) +
  scale_fill_discrete(
    labels = c(
      "All insects" = "All insects",
      "All insects_un" = "All insects unweighted"
    )
  ) +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

all_insect_trend_comp

ggsave(filename = paste0("XXX_local_link/all_insect_trend_comp_", weighting_setting, ".png"), plot = all_insect_trend_comp, dpi = 300, height = 5, width = 7)


# Pollinator           
# create functional group figure 
Pollinator_trend_comp <- ggplot(combi_plot_data[combi_plot_data$group %in% c("Pollinator", "Pollinator_un"),], aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(aes_string(ymin = "lower", ymax = "upper", fill = "group"),
              alpha = 0.3, colour = NA) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  scale_colour_discrete(
    labels = c(
      "Pollinator" = "Pollinator",
      "Pollinator_un" = "Pollinator unweighted"
    )
  ) +
  scale_fill_discrete(
    labels = c(
      "Pollinator" = "Pollinator",
      "Pollinator_un" = "Pollinator unweighted"
    )
  ) +
  ylab("Occupancy index (1990 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1990, 2021), expand = c(0, 0)) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

Pollinator_trend_comp

ggsave(filename = paste0("XXX_local_link/Pollinator_trend_comp_trend_comp_", weighting_setting, ".png"), plot = Pollinator_trend_comp, dpi = 300, height = 5, width = 7)

# Key food resource           
# create functional group figure 
Key_food_resource_trend_comp <- ggplot(combi_plot_data[combi_plot_data$group %in% c("Key food resource", "Key food resource_un"),], aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(aes_string(ymin = "lower", ymax = "upper", fill = "group"),
              alpha = 0.3, colour = NA) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  scale_colour_discrete(
    labels = c(
      "Key food resource" = "Key food resource",
      "Key food resource_un" = "Key food resource unweighted"
    )
  ) +
  scale_fill_discrete(
    labels = c(
      "Key food resource" = "Key food resource",
      "Key food resource_un" = "Key food resource unweighted"
    )
  ) +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

Key_food_resource_trend_comp

ggsave(filename = paste0("XXX_local_link/Key_food_resource_trend_comp_", weighting_setting, ".png"), plot = Key_food_resource_trend_comp, dpi = 300, height = 5, width = 7)

# Pest control          
# create functional group figure 
Pest_control_trend_comp <- ggplot(combi_plot_data[combi_plot_data$group %in% c("Pest control", "Pest control_un"),], aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(aes_string(ymin = "lower", ymax = "upper", fill = "group"),
              alpha = 0.3, colour = NA) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  scale_colour_discrete(
    labels = c(
      "Pest control" = "Pest control",
      "Pest control_un" = "Pest control unweighted"
    )
  ) +
  scale_fill_discrete(
    labels = c(
      "Pest control" = "Pest control",
      "Pest control_un" = "Pest control unweighted"
    )
  ) +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

Pest_control_trend_comp

ggsave(filename = paste0("XXX_local_link/Pest_control_trend_comp_trend_comp_", weighting_setting, ".png"), plot = Pest_control_trend_comp, dpi = 300, height = 5, width = 7)

# Freshwater          
# create functional group figure 
Freshwater_trend_comp <- ggplot(combi_plot_data[combi_plot_data$group %in% c("Freshwater", "Freshwater_un"),], aes_string(x = "year", y = "indicator", colour = "group")) +
  theme_bw() +
  geom_ribbon(aes_string(ymin = "lower", ymax = "upper", fill = "group"),
              alpha = 0.3, colour = NA) +
  geom_line(size = 0.5) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  scale_colour_discrete(
    labels = c(
      "Freshwater" = "Freshwater",
      "Freshwater_un" = "Freshwater unweighted"
    )
  ) +
  scale_fill_discrete(
    labels = c(
      "Freshwater" = "Freshwater",
      "Freshwater_un" = "Freshwater unweighted"
    )
  ) +
  ylab("Occupancy index (1970 = 100)\n") +
  xlab("\nYear") +
  scale_y_continuous(limits = c(0, 150), expand = c(0, 0)) +
  scale_x_continuous(limits = c(1970, 2021), expand = c(0, 0)) +
  theme(text = element_text(size = 12),
        #aspect.ratio = 1,
        legend.title = element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        legend.text = element_text(size = 9))

Freshwater_trend_comp

ggsave(filename = paste0("XXX_local_link/Freshwater_trend_comp_trend_comp_", weighting_setting, ".png"), plot = Freshwater_trend_comp, dpi = 300, height = 5, width = 7)


# plot against each other
library(reshape2)

# prep the data for the plots
df_wide <- dcast(combi_plot_data, year ~ group, value.var = "indicator")
df_wide$year <- as.numeric(as.character(df_wide$year))

# pollinator plot
pollinator_comp <- ggplot(df_wide[df_wide$year>1989,], aes(x = Pollinator, y = Pollinator_un, colour = year)) +
  theme_bw() +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red") +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  xlab("Weighted pollinator occupancy estimates") +
  ylab("Unweighted pollinator occupancy estimates") + 
  xlim(60, 105) +
  ylim(60, 105)

pollinator_comp

ggsave(filename = paste0("XXX_local_link/pollinator_comp_", weighting_setting, ".png"), plot = pollinator_comp, dpi = 300, height = 5, width = 6)
  
# Freshwater plot
freshwater_comp <- ggplot(df_wide, aes(x = Freshwater, y = Freshwater_un, colour = year)) +
  theme_bw() +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red") +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  xlab("Weighted freshwater occupancy estimates") +
  ylab("Unweighted freshwater occupancy estimates") +
  xlim(55, 140) +
  ylim(55, 140)

freshwater_comp

ggsave(filename = paste0("XXX_local_link/freshwater_comp_", weighting_setting, ".png"), plot = freshwater_comp, dpi = 300, height = 5, width = 6)

# pest_control plot
names(df_wide) <- gsub("Pest control", "Pest_control", names(df_wide))
  
pest_control_comp <- ggplot(df_wide, aes(x = Pest_control, y = Pest_control_un, colour = year)) +
  theme_bw() +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red") +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  xlab("Weighted pest control occupancy estimates") +
  ylab("Unweighted pest control occupancy estimates") +
  xlim(70, 105) +
  ylim(70, 105)

pest_control_comp

ggsave(filename = paste0("XXX_local_link/pest_control_comp_", weighting_setting, ".png"), plot = freshwater_comp, dpi = 300, height = 5, width = 6)

# key_food_resource plot
names(df_wide) <- gsub("Key food resource", "Key_food_resource", names(df_wide))

key_food_resource_comp <- ggplot(df_wide, aes(x = Key_food_resource, y = Key_food_resource_un, colour = year)) +
  theme_bw() +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red") +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  xlab("Weighted key food resource occupancy estimates") +
  ylab("Unweighted key food resource occupancy estimates") +
  xlim(60, 130) +
  ylim(60, 130)

key_food_resource_comp

ggsave(filename = paste0("XXX_local_link/key_food_resource_comp_", weighting_setting, ".png"), plot = freshwater_comp, dpi = 300, height = 5, width = 6)

# All insects plot
names(df_wide) <- gsub("All insects", "All_insects", names(df_wide))

all_insects_comp <- ggplot(df_wide, aes(x = All_insects, y = All_insects_un, colour = year)) +
  theme_bw() +
  geom_point() + 
  scale_color_gradient(low = "blue", high = "red") +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  xlab("Weighted all insects occupancy estimates") +
  ylab("Unweighted all insects occupancy estimates") +
  xlim(80, 100) +
  ylim(80, 100)


all_insects_comp

ggsave(filename = paste0("XXX_local_link/all_insects_comp_", weighting_setting, ".png"), plot = freshwater_comp, dpi = 300, height = 5, width = 6)

