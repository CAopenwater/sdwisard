library(tidyverse)

# data.frame of colnames = c(psid, water_system_name, county, zipcode)
water_systems <- tibble(psid = c("103039", "103040"),
                        water_system_name = c("A","B"),
                        county = c("D","E"),
                        zipcode = c(90201, 94601))

usethis::use_data(water_systems, overwrite = TRUE)

# data.frame of colnames = c(storet, analytes)
analytes <- tibble(storet  = c("00081", "00086"),
                   analyte = c("COLOR", "ODOR THRESHOLD @ 60 C"))

usethis::use_data(analytes, overwrite = TRUE)

# internal of colnames = c(psid, storet, analyte)
files <- list.files("data-raw", pattern = ".csv", full.names = TRUE)
psids <- str_remove_all(files, ".csv") %>% basename()

psid_analyte <- purrr::map2_df(
  files, psids, ~ read_csv(.x) %>%
  group_by(STORE_NUM, CHEMICAL) %>%
  summarise(start_date = min(SAMP_DATE), end_date = max(SAMP_DATE), n = n()) %>%
  mutate(psid = .y)
  ) %>%
  select(psid, storet = STORE_NUM, analyte = CHEMICAL, start_date, end_date, n)


usethis::use_data(psid_analyte, overwrite = TRUE)
