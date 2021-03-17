# install.packages("readxl")
library("readxl")

# read raw excel file
raw.taxonomy <- read_excel("source/Taxonomie ShareStats versie 17 maart 2021.xlsx", sheet = 1)

# select only the levels to work with
taw.taxonomy.levels <- raw.taxonomy[,1:4]

# Restructure file list view

n.cols <- dim(taw.taxonomy.levels)[1]

terms <- vector()
level.vector <- vector()
level1 = level2 = level3 = level4 = character()


htmlList <- file("taxonomy_list.html", open = "w+")
cat("<ul>", file = htmlList, append=TRUE, sep = "\n")


for(row in 1:n.cols) {
  
  for(col in 1:4) {
    
    # Only print if cels are not empty
    if(!is.na(taw.taxonomy.levels[row, col])) {

      value <- as.character(taw.taxonomy.levels[row, col])
      
      if(col == 1 && !is.na(taw.taxonomy.levels[row, col])) { level1 = value; level2 = level3 = level4 = character(); }
      if(col == 2 && !is.na(taw.taxonomy.levels[row, col])) { level2 = value; level3 = level4 = character(); }
      if(col == 3 && !is.na(taw.taxonomy.levels[row, col])) { level3 = value; level4 = character(); }
      if(col == 4 && !is.na(taw.taxonomy.levels[row, col])) level4 = value;
      
      # Determine level per line
      if(length(level2) == 0 && length(level3) == 0 && length(level4) == 0) level = 1
      if(length(level2) != 0 && length(level3) == 0 && length(level4) == 0) level = 2
      if(length(level2) != 0 && length(level3) != 0 && length(level4) == 0) level = 3
      if(length(level2) != 0 && length(level3) != 0 && length(level4) != 0) level = 4

      
      print(paste(level1, level2, level3, level4))
      level.vector <- append(level.vector, level)
 
      # Add new sub list for new level
      if(row > 1 && level.vector[row] - level.vector[row - 1] ==  1) cat("<ul>", file = htmlList, sep = "\n")
      # Close sublists for previous levels.
      if(row > 1 && level.vector[row] - level.vector[row - 1] == -1) cat("</ul>", file = htmlList, sep = "\n")
      if(row > 1 && level.vector[row] - level.vector[row - 1] == -2) cat("</ul></ul>", file = htmlList, sep = "\n")
      if(row > 1 && level.vector[row] - level.vector[row - 1] == -3) cat("</ul></ul></ul>", file = htmlList, sep = "\n")
 
      # Add list elements per level     
      if(level == 1) cat(paste0('<li alt="',level1,'">',level1,"</li>"), file = htmlList, sep = "\n")
      if(level == 2) cat(paste0('<li alt="',level1," / ",level2,'">',level2,"</li>"), file = htmlList, sep = "\n")
      if(level == 3) cat(paste0('<li alt="',level1," / ",level2," / ",level3,'">',level3,"</li>"), file = htmlList, sep = "\n")
      if(level == 4) cat(paste0('<li alt="',level1," / ",level2," / ",level3," / ",level4,'">',level4,"</li>"), file = htmlList, sep = "\n")

    }
  }
}

cat("</ul>", file = htmlList)
close(htmlList)