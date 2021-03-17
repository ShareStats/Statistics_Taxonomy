install.packages("yaml")
install.packages("data.tree")
library("yaml")
library("data.tree")

Statistics.Taxonomy <- read_yaml("test_YAML/Test_Statistics_Taxonomy.yaml")

# osList <- yaml.load(Statistics.Taxonomy)
osNode <- as.Node(Statistics.Taxonomy)

print(osNode, "nl")

# yaml -> list of lists (?yaml::yaml.load) -> data.tree (?as.Node.list)

save(osNode, file="test_YAML/nodes.rdata")
