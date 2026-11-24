# Create data object for sparta occupancy model run. 

rm(list=ls()) # clear R

# add packages
require(BRCmap)
require(occAssess)
require(ggplot2)
library(sparta)

# load data
#load("input_data/LeafSeedBeetles_190411_Cleaned_Data.rdata")
load("XXX_local_link/BNM_2022.rdata")


# convert taxa_data to merged data object

taxa_run <- "BNM_2022"

taxa_data <- taxa_data[, c("CONCEPT", "TO_GRIDREF", "TO_STARTDATE", "YEAR")]

# sort column names 
names(taxa_data) <- c("species", "site", "time_period", "year")

nrow(taxa_data)

# if butterflies make sure only 1km data retained
if(taxa_run == "BNM_2022"){
  taxa_data$site_1km <- reformat_gr(taxa_data$site, prec_out = 1000)
  taxa_data$PRECISION <- det_gr_precision(taxa_data$site_1km)
  taxa_data <- taxa_data[taxa_data$PRECISION == 1000,]
  taxa_data <- taxa_data[!is.na(taxa_data$site_1km),]
  nrow(taxa_data)
  taxa_data <- taxa_data[,c("species","site_1km", "time_period", "year")]
  names(taxa_data) <- gsub("site_1km", "site", names(taxa_data))
}

# drop duplicate rows
nrow(taxa_data) #
taxa_data <- unique(taxa_data)
nrow(taxa_data) # 

### run prep occ det func code ### NOTE: we lose 485 records when looking at unique 1km data combo... 
formattedOccData <- sparta::formatOccData(taxa = taxa_data$species,
                                  site = taxa_data$site,
                                  survey = taxa_data$time_period)

visitData <- formattedOccData

save(visitData, file = "input_data/BNM_2022_1km_visitData.rdata") #
