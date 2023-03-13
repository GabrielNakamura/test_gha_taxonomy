library(here)
library(fishR)
library(rfishbase)
library(glue)
occ <- read.csv(here::here("data_table.csv"), sep = ",")

# searching species names in CAS ------------------------------------------

spp_names <- unique(occ$spp)
q1 <- search_cas(query = spp_names, type = "species")
valid <- spp_names[spp_names %in% q1$valid_name]
not_valid <- spp_names[!spp_names %in% q1$valid_name]

paste0(
  "# Testing gha for automated taxonomic checking ",
  format(Sys.Date(), '%b %d %Y'),
  ".
<hr> \n
",
  paste(glue("Not valid species names: {glue_collapse(not_valid, sep = ', ')}"),
        glue("Not valid species names: {glue_collapse(not_valid, sep = ', ')}"),
        sep = "\t")
) |> writeLines("01_check_tax_names/README.md")

