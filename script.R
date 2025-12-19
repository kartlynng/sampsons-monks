# Part 0: Setup
install.packages("lda")
install.packages("igraph")
install.packages("networkD3")

library(lda)
library(igraph)
library(networkD3)

#Load data
data(sampson)

# Check type
class(sampson) # a list

# Show names of matrices within sampson
names(sampson) # 10 matrices

# Use the matrix: SAMPLK2
samplk2 <- sampson[["SAMPLK2"]]  #or sampson$SAMPLK2
samplk2
# Get the vectors (monks) of samplk2
monk_names <- rownames(samplk2)
monk_names # 18 monks total


# Answers Parts 1 - 3:
# Part 1: Visualizing the Network

# Static plot with igraph:
graph <- graph_from_adjacency_matrix(  # Convert the matrix to an igraph object
  samplk2, 
  mode = "directed"
)
# Then, plot:
plot(
  graph,
  vertex.label = monk_names,
  vertex.color = "pink",
  layout = layout_with_fr, #cleaner layout 
  edge.arrow.size = 0.3,
  main = "Static - Monk Network (SAMPLK2)"
)

# Interactive plot with networkD3:
# networkD3 needs dataframes of nodes and edges!

# Prepare nodes & edges dataframes
nodes <- data.frame(name = monk_names, group = 2)  #group indicates which color
nodes

edges <- which(samplk2 > 0, arr.ind = TRUE) #check if a tie exists between monks & returns row and column indices of all non-zero entries
edges <- data.frame(from = edges[, 1] - 1,  #subtract 1 because networkD3 uses zero-based indexing
                    to = edges[, 2] - 1)
edges #each row = a directed edge from 1 monk to another

# Then, plot:
forceNetwork(
  Links = edges,
  Nodes = nodes,
  Source = "from",
  Target = "to",
  NodeID = "name",
  Group = "group",
  opacity = 0.9,
  zoom = TRUE
)
# In the interactive network plot: Although the data contain directed edges, the interactive plot does not display edge direction, 
# making it difficult to distinguish outgoing and incoming ties.
# While the 3D interactive layout improves overall visibility of the network, it obscures monk labels and does not clearly convey directionality.



# Part 2: Summary Statistics on a Sociomatrix

# Out-degree: "the number of ties sent/ how many monks they said they liked"
out_degree <- rowSums(samplk2)
out_degree
# In-degree: "the number of ties received"
in_degree <- colSums(samplk2)
in_degree
# Mean tie strength: row & column means
row_mean <- rowMeans(samplk2)
row_mean

col_mean <- colMeans(samplk2)
col_mean
# Store results in a list that keeps track of different measures:
summary_stats <- list(
  out_degree = out_degree,
  in_degree = in_degree,
  row_mean = row_mean,
  col_mean = col_mean
)
summary_stats
# A barplot of the in-degree statistics:
barplot(
  in_degree,
  las = 2,                       #rotate x-axis labels to be vertical -> easier to read!
  names.arg = monk_names,        #assign monk_names as labels on x-axis
  col = "pink",
  main = "The Number of Ties Received",
  ylab = "Count"
)
# A barplot of the out-degree statistics:
barplot(
  out_degree,
  las = 2,                       
  names.arg = monk_names,        
  col = "light green",
  main = "The Number of Ties Sent",
  ylab = "Count"
)
# Which monk is most liked? = The one with the highest in_degree
most_liked_index <- which.max(in_degree)

most_liked_monk <- monk_names[most_liked_index]
most_liked_monk       # "ROMUL_10" with 18 votes received!

# Which monk is least liked? = The one with the lowest in_degree
least_liked_index <- which.min(in_degree)

least_liked_monk <- monk_names[least_liked_index]
least_liked_monk      # "AMBROSE_9" with 2 votes received!


# Part 3: A Simple Model of A Social Network

# This function generates liking relationships.
# To generate disliking relationships, use: sample(-3:0, ...) instead.

get_monk_network <- function(n_monks = 18){
  matrix <- matrix(0, nrow = n_monks, ncol = n_monks)
  for (i in 1:n_monks){
    row <- sample(0:3, n_monks, replace = TRUE)  #each monk is allowed up to 3 likes
  # no self-likes - diagonal element should be 0
    row[i] <- 0
  # assign row to matix
    matrix[i,] <- row
  }
matrix
}

# I will generate 1 and use it for part 4 comparison
generated_network <- get_monk_network(n_monks = 18)
generated_network 