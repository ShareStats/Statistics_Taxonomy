# install.packages("readxl")
library("readxl")

# read raw excel file
raw.taxonomy <- read_excel("source/Taxonomie ShareStats versie 17 maart 2021.xlsx", sheet = 1)

# select only the levels to work with
taw.taxonomy.levels <- raw.taxonomy[,1:4]

# Restructure file list view

n.cols <- dim(taw.taxonomy.levels)[1]

terms <- vector()
level1 = level2 = level3 = level4 = character()

for(row in 1:n.cols) {
  
  for(col in 1:4) {
    
    # Determine top levels
    if(!is.na(taw.taxonomy.levels[row, col])) {

      value <- as.character(taw.taxonomy.levels[row, col])
      
      # [TODO: Sharon] Last level value still carries over to new level 1
      # [1] "Variable type Ratio  " should be [1] "Variable type   "
      
      if(col == 1 && !is.na(taw.taxonomy.levels[row, col])) level1 = value; # level2 = character();
      if(col == 2 && !is.na(taw.taxonomy.levels[row, col])) level2 = value; # level3 = character();
      if(col == 3 && !is.na(taw.taxonomy.levels[row, col])) level3 = value; # level4 = character();
      if(col == 4 && !is.na(taw.taxonomy.levels[row, col])) level4 = value;
      
      print(paste(level1, level2, level3, level4))
      
      
      
    }
    
  }
}