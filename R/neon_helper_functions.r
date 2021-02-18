# loc_info <- table_location_raw
# loc_col_names <- c("domainID", "siteID", "namedLocation")
# ancillary_var_names <- c("namedLocation",
#   "plotType", "nlcdClass", "geodeticDatum")

#####################################################################################
# helper function to make neon location tables with appropriate nexted references
# not to be exported
#########################################
make_neon_location_table <- function(loc_info, loc_col_names){
  
  table_location <- suppressMessages(
    loc_info %>% 
      ecocomDP::make_location(cols = loc_col_names))
  
  # code to handle updated make_location (updated 18 Sep 2020 in make_location branch)
  if(class(table_location) == "list" &&
     "location" %in% names(table_location)){
    
    table_location <- table_location$location %>%
      dplyr::rowwise() %>%
      dplyr::mutate(
        location_name = location_name %>% 
          strsplit("=") %>%
          unlist() %>%
          dplyr::last()) 
  }
  
  
  # populate latitude
  if("decimalLatitude" %in% names(loc_info)) table_location$latitude <- 
    loc_info$decimalLatitude[match(table_location$location_name, loc_info$namedLocation)] 
  
  #populate longitude
  if("decimalLongitude" %in% names(loc_info)) table_location$longitude <- 
    loc_info$decimalLongitude[match(table_location$location_name, loc_info$namedLocation)] 
  
  # populate elevation
  if("elevation" %in% names(loc_info)) table_location$elevation <- 
    loc_info$elevation[match(table_location$location_name, loc_info$namedLocation)] 
  
  # replace parent_id with parent_name
  table_location$parent_location_id <- table_location$location_name[
    match(table_location$parent_location_id, table_location$location_id)]
  
  # replace loc_id with meaningful names
  table_location$location_id <- table_location$location_name
  
  # get neon location info lookup tables
  neon_domain_list <- ecocomDP:::neon_site_list %>%
    dplyr::select(`Domain Number`, `Domain Name`) %>%
    dplyr::distinct()
  
  neon_site_info_list <- ecocomDP:::neon_site_list %>%
    dplyr::select(-c(`Domain Number`,`Domain Name`)) %>%
    dplyr::distinct()
  
  
  # update location_names and lat longs where possible
  for(location_id in table_location$location_id){
    if(location_id %in% neon_domain_list$`Domain Number`){
      table_location$location_name[table_location$location_id == location_id] <- 
        neon_domain_list$`Domain Name`[neon_domain_list$`Domain Number`==location_id]
    }else if(location_id %in% neon_site_info_list$`Site ID`){
      table_location$location_name[table_location$location_id == location_id] <- 
        neon_site_info_list$`Site Name`[neon_site_info_list$`Site ID`==location_id]
      
      table_location$latitude[table_location$location_id == location_id] <- 
        neon_site_info_list$Latitude[neon_site_info_list$`Site ID`==location_id]
      
      table_location$longitude[table_location$location_id == location_id] <- 
        neon_site_info_list$Longitude[neon_site_info_list$`Site ID`==location_id]
      
    }
  }
  
  return(table_location)
}


#####################################################################################
# helper function to make neon ancillary location tables
#########################################
make_neon_ancillary_location_table <- function(loc_info, loc_col_names, ancillary_var_names = NULL){
  
  # make ancillary table that indicates the location type 
  table_location_ancillary <- loc_info %>% 
    dplyr::select_at(dplyr::vars(loc_col_names)) %>%
    tidyr::pivot_longer(
      cols = everything(),
      names_to = "value",
      values_to = "location_id") %>%
    dplyr::mutate(
      variable_name = "NEON location type",
      location_ancillary_id = paste0("NEON_location_type_",location_id)) %>%
    dplyr::distinct()
  
  # add other ancillary variables to the long-format table
  if(!is.null(ancillary_var_names)){
    table_location_ancillary <- loc_info %>% 
      dplyr::select_at(dplyr::vars(ancillary_var_names)) %>%
      tidyr::pivot_longer(
        cols = -namedLocation,
        names_to = "variable_name",
        values_to = "value") %>%
      dplyr::rename(location_id = namedLocation) %>%
      dplyr::mutate(
        location_ancillary_id = paste0(variable_name, "_", location_id)) %>%
      dplyr::distinct() %>%
      dplyr::bind_rows(., table_location_ancillary)
  }
  
  return(table_location_ancillary)
}