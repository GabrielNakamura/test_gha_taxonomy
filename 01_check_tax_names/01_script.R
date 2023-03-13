library(here)
library(rFishTaxa)
library(rfishbase)
library(glue)
library(rgbif)
occ <- read.csv(here::here("data_table.csv"), sep = ",")

# searching species names in CAS ------------------------------------------
spp <- unique(occ$spp)
spp_names <- name_backbone_checklist(spp)
table <- spp_names |>
  knitr::kable()

paste0(
  "# Testing gha for automated taxonomic checking ",
  format(Sys.Date(), '%b %d %Y'),
  ".
<hr> \n
",
  paste(table, collapse = "\n")
) |> writeLines("01_check_tax_names/README.md")


