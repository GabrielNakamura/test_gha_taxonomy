usethis::edit_r_environ(scope = "project")
usethis::use_git_ignore(".Renviron")

library(dplyr)
library(readr)  
library(rgbif) # for occ_download
# The 60,000 tree names file I downloaded from BGCI
file_url <- c("Astyanax bimaculatus", "Astyanax scabripinis", "Astyanax fasciatus", "Astyanax lacustris")
gbif_taxon_keys <- 
  file_url %>% 
  name_backbone_checklist()  %>% # match to backbone
  filter(!matchType == "NONE") %>% # get matched names
  pull(usageKey) # get the gbif taxonkeys
# gbif_taxon_keys should be a long vector like this c(2977832,2977901,2977966,2977835,2977863)
# !!very important here to use pred_in!!
occ_download(
  pred_in("taxonKey", gbif_taxon_keys),
  format = "SIMPLE_CSV",
  user=Sys.getenv("LOG_GBIF"),pwd=Sys.getenv("PWD_GBIF"),email=Sys.getenv("MAIL")
)


occ_download_wait('0086376-230224095556074')
d <- occ_download_get('0086376-230224095556074') %>%
    occ_download_import()

colnames(d)
occ <- data.frame(spp = d$species, x = d$decimalLongitude, y = d$decimalLatitude)
occ <- occ[- which(is.na(occ$x) == TRUE & is.na(occ$y) == TRUE), ]
write.csv(x = occ, file = here::here("data_table.csv"))

