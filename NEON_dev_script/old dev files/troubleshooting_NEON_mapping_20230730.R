# macroinverts
# dup locations
# SYCA.AOS.reach

my_result_read_data <- read_data(
  id = "neon.ecocomdp.20120.001.001",
  site = "SYCA",
  startdate = "2020-01",
  enddate = "2023-07",
  token = Sys.getenv("NEON_TOKEN"),
  check.size = FALSE)

my_result_read_data$validation_issues
my_result_read_data$metadata$data_package_info




# fish
# # dup locations
# GUIL.AOS.fish.point.01
# GUIL.AOS.fish.point.02
# GUIL.AOS.fish.point.03
my_result_read_data <- read_data(
  id = "neon.ecocomdp.20107.001.001",
  site = "GUIL",
  startdate = "2016-01",
  enddate = "2020-12",
  token = Sys.getenv("NEON_TOKEN"),
  check.size = FALSE)

my_result_read_data$validation_issues
my_result_read_data$metadata$data_package_info





# plant

my_result_read_data <- read_data(
  id = "neon.ecocomdp.10058.001.001",
  site = "BARR",
  startdate = "2012-06",
  enddate = "2023-07",
  token = Sys.getenv("NEON_TOKEN"),
  check.size = FALSE)

my_result_read_data$validation_issues
my_result_read_data$metadata$data_package_info



# bird 
# dup uuid = 3a0cc717-2a3e-4ae6-b82a-ca2c58ce0459
# UNDE 2021-06-10
# issue is this is a real unresolvable dup in the brd_perpoint table - not sure what to do to fix. 

my_result_read_data <- read_data(
  id = "neon.ecocomdp.10003.001.001",
  site = "UNDE",
  startdate = "2021-06",
  enddate = "2021-06",
  token = Sys.getenv("NEON_TOKEN"),
  check.size = FALSE)

my_result_read_data$validation_issues
my_result_read_data$metadata$data_package_info