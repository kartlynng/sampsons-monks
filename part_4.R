# Part 4: Applies the same techniques used in Part 1 & 2 with the Network simulated by the Model in Part 3

# Visualizations:

# First, name the monks from 1-18:
names <- paste("Monk", 1:nrow(generated_network))
rownames(generated_network) <- names
colnames(generated_network) <- names
generated_network

# Second, plot:
# Static plot with igraph:
graph_model <- graph_from_adjacency_matrix(  # Convert the matrix to an igraph object
  generated_network, 
  mode = "directed"
)
# Then, plot:
plot(
  graph_model,
  vertex.label = names,
  vertex.color = "blue",
  layout = layout_with_fr, #cleaner layout 
  edge.arrow.size = 0.3,
  main = "Static - Monk Network (generated_network)"
)

# Interactive plot with networkD3:
# Prepare nodes & edges dataframes:
nodes_1 <- data.frame(name = names, group = 1)  
nodes_1

edges_1 <- which(generated_network > 0, arr.ind = TRUE) 
edges_1 <- data.frame(from = edges_1[, 1] - 1,  
                    to = edges_1[, 2] - 1)
edges_1 

# Then, plot:
forceNetwork(
  Links = edges_1,
  Nodes = nodes_1,
  Source = "from",
  Target = "to",
  NodeID = "name",
  Group = "group",
  opacity = 0.9,
  zoom = TRUE
)

# Summary Stats:
# Out-degree: "the number of ties sent/ how many monks they said they liked"
out_degree_1 <- rowSums(generated_network)
out_degree_1
# In-degree: "the number of ties received"
in_degree_1 <- colSums(generated_network)
in_degree_1
# Mean tie strength: row & column means
row_mean_1 <- rowMeans(generated_network)
row_mean_1

col_mean_1 <- colMeans(generated_network)
col_mean_1
# Store results in a list that keeps track of different measures:
summary_stats_1 <- list(
  out_degree = out_degree_1,
  in_degree = in_degree_1,
  row_mean = row_mean_1,
  col_mean = col_mean_1
)
summary_stats_1
# A barplot of the in-degree statistics:
barplot(
  in_degree_1,
  las = 2,                      
  names.arg = names,        
  col = "purple",
  main = "The Number of Ties Received",
  ylab = "Count"
)
# A barplot of the out-degree statistics:
barplot(
  out_degree_1,
  las = 2,                       
  names.arg = names,        
  col = "dark blue",
  main = "The Number of Ties Sent",
  ylab = "Count"
)
# Which monk is most liked? = The one with the highest in_degree
most_liked_index_1 <- which.max(in_degree_1)

most_liked_monk_1 <- names[most_liked_index_1]
most_liked_monk_1      # "Monk 12" with 33 votes received!

# Which monk is least liked? = The one with the lowest in_degree
least_liked_index_1 <- which.min(in_degree_1)

least_liked_monk_1 <- names[least_liked_index_1]
least_liked_monk_1     # "Monk 17" with 16 votes received!