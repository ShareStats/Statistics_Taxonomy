library(dplyr)
library(tidyr)
library(stringr)
library(readxl)
library(data.tree)
library(rjson)

get_taxonomie <- function(xlsx_file) {
    tax_levels <- read_excel(xlsx_file, sheet = 1) %>%
                  pivot_longer( cols = starts_with("Level ")) %>%
                  mutate(level = as.numeric(str_replace_all(name, "Level ", ""))) %>%
                  select(level, value) %>%
                  drop_na()
    n_levels = max(tax_levels$level)          
    
    levels = c(Node$new("Taxonomie"), rep(NA, n_levels))
    for (r in 1:nrow(tax_levels)) {
      l = tax_levels[r,]$level
      levels[[l+1]] <- levels[[l]]$AddChild(tax_levels[r, ]$value)
    }             
    
    return(levels[[1]])
}


tax = get_taxonomie("source/Taxonomie ShareStats versie 17 maart 2021.xlsx")
tax_list = ToListExplicit(tax, unname = TRUE, 
                               nameName = "name", childrenName = "sublevels")$sublevels
                  
write(toJSON(tax_list, indent=2), file="taxonomie.json")
