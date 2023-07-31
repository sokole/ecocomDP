file_name <- 
  # "neon.ecocomdp.10003.001.001_data_download.RDS" # -- obs dups -- real dup in data in brd_perpoint table, not sure what to do
# "neon.ecocomdp.10022.001.001_data_download.RDS" # -- good
# "neon.ecocomdp.10043.001.001_data_download.RDS" # -- good
# "neon.ecocomdp.10058.001.001_data_download.RDS" # -- location dups - fixed by taking most recent version
# "neon.ecocomdp.10072.001.001_data_download.RDS" # -- good
# "neon.ecocomdp.10092.001.001_data_download.RDS" # -- good
# "neon.ecocomdp.10093.001.001_data_download.RDS" # -- datetime format issues, dup location_id
# "neon.ecocomdp.20107.001.001_data_download.RDS" # -- location dups
# "neon.ecocomdp.20120.001.001_data_download.RDS" # -- 1 location dup - fixed
# "neon.ecocomdp.20166.001.001_data_download.RDS" # -- good
# "neon.ecocomdp.20219.001.001_data_download.RDS" # -- good

data_list <- readRDS(file_name)

data_list$metadata$data_package_info
data_list$validation_issues



# bird dups
obs_tab <- data_list$tables$observation[72081:72086,]



# plant dups -- locatoin table
# Primary keys. The location table contains non-unique primary keys in the column location_id at rows: 1713 2417"
loc_tab <- data_list$tables$location[c(1712, 1713, 2416,2417),]

# plots with duplicate info
BARR_052.basePlot.div
MLBS_064.basePlot.div



# fish dups -- location table
# "Primary keys. The location table contains non-unique primary keys in the column 
# location_id at rows: 115 117 119 124"
loc_tab <- data_list$tables$location[114:120,]

# macroinvert location dup
# "Primary keys. The location table contains non-unique primary keys in the column 
# location_id at rows: 179"
loc_tab <- data_list$tables$location[178:180,]
