library(dplyr)
library(tidyr)
library(stringr)
library(readxl)
library(data.tree)
library(rjson)

process_levels <- function(data, label="Taxonomy") {
    "data frame columns: levels and values"
    n_levels = max(data$level)          
    
    levels = c(Node$new(label), rep(NA, n_levels))
    for (r in 1:nrow(data)) {
      l = data[r,]$level
      levels[[l+1]] <- levels[[l]]$AddChild(data[r, ]$value)
    }             
    
    return(levels[[1]])
}


file = "source/Taxonomie ShareStats versie 17 maart 2021.xlsx"

# TAXONOMY
stats_df <- read_excel(file, sheet = 1) %>%
            pivot_longer( cols = starts_with("Level ")) %>%
            mutate(level = as.numeric(str_replace_all(name, "Level ", ""))) %>%
            select(level, value) %>%
            drop_na()

# TAGS
tags_df <- read_excel(file, sheet = 2) %>%
            rename("1" = "Type of question", "2" = "...2") %>%
            pivot_longer( cols = c("1", "2")) %>%
            mutate(level = as.numeric(name)) %>%
            select(level, value) %>%
            drop_na()


# make taxonomy 
stats = process_levels(stats_df, label="Statistics Taxonomy")
tags = process_levels(tags_df, label="Tags")

taxonomy = Node$new("base")
taxonomy$AddChildNode(stats)
taxonomy$AddChildNode(tags)

# export to single JSON file
tmp = ToListSimple(taxonomy, unname = TRUE)
write(toJSON(tmp, indent=2), file="taxonomy.json")
