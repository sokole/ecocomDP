% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flatten_ecocomDP.R
\name{flatten_ecocomDP}
\alias{flatten_ecocomDP}
\title{Merge tables in ecocomDP dataset}
\usage{
flatten_ecocomDP(data.list)
}
\arguments{
\item{data.list}{(list of data frames) A named list of data frames, each of which is an 
ecocomDP table.}
}
\value{
(data.frame) a single data.frame of merged tables for an ecocomDP data package
}
\description{
This function joins a list of data.frames following the ecocomDP data pattern

Check for valid date and time formats
}
\examples{
\dontrun{
# Flatten NEON data
all_data <- ecocomDP::read_data(
id = "DP1.20120.001",
site= c('COMO','LECO'),
startdate = "2019-06",
enddate = "2019-09",
token = Sys.getenv("NEON_TOKEN"))

my_list_of_tables <- all_data[[1]]$tables
flat_data <- ecocomDP::flatten_ecocomDP(my_list_of_tables)

# Flatten EDI data
all_data <- ecocomDP::read_data("edi.290.1")
my_list_of_tables <- all_data[[1]]$tables
flat_data <- ecocomDP::flatten_ecocomDP(my_list_of_tables)
}

}
