# sampsons-monks
Project 2: Sampson's Monk

# Overview:
- In this project, I will analyze and model Sampson's Monk dataset, a classic dataset that captures relationships among monks in a monastery.

# Dataset Description:
- The Sampson’s Monk dataset represents directed social ties among monks.
- The data is stored as an adjacency matrix, where:
1. Rows represent senders of ties.
2. Columns represent receivers of ties.

# Methodology:
**1. Data Preparation:**
- Install and load 3 packages:
    a. **lda:** provides access to the Sampson's Monk dataset.
    b. **igraph:** used for creating and analyzing static network plots.
        - Accepts an adjacency matrix!
    c. **networkD3:** used to generate interactive network visualizations.
        - Needs dataframs of nodes and edges, not an adjacency matrix!

**2. Process:**
## Key Terminology:
1. *nodes (or vertices):* objects/points in a network. In this dataset, each node = a monk.
2. *edges (or links):* the connections/relationships between nodes. In Sampson's Monk dataset, edges are **directed**.
3. *out-degree:* the number of outgoing edges from a node (~ how many ties a monk sends to others).
4. *in-degree:* the number of incoming edges to a node (~ how many ties a monk receives from others).

## Part 1: Visualizing the Network
- To visualize relationships among the monks, I created 2 network visualizations using the Sampson’s Monk dataset from the lda package. Specifically, I used the **SAMPLK2** adjacency matrix, which represents directed liking relationships among monks.
1. Data Extraction:
- Since sampson is a list containing several network matrices, I used **double brackets [[ ]]** to extract the matrix (SAMPLK2).

2. Static Network Visualization: 
- I created a static network plot using **igraph::plot.igraph()** to obtain a clear overall structure of the directed relationships & to identify patterns in connectivity.

+ Reference: [text](https://igraph.org/r/html/1.2.5/plot.igraph.html)

3. Interactive Network Visualization: 
- I used **networkD3::forceNetwork()**, which allows dynamic exploration of the network.

+ Reference: [text](https://www.rdocumentation.org/packages/networkD3/versions/0.4.1/topics/forceNetwork)

## Part 2: Summary Statistics
1. Out-degree: rowSums()
2. In-degree: colSums()
3. Mean tie strength: rowMeans() and colMeans()
4. Create a list: list(name1 = vector1,...)
5. A barplot: barplot()
6. Most-liked and least-liked monks: 
    a. Find the index of each: which.max(in_degree) & which.min(in_degree)
    b. Get the names of monks by subsetting monk_names with the indices just found: monk_names[index]

## Part 3: A Simple Model of A Social Network
- To further investigate the social dynamics underlying the monks’ network:
    a. I wrote a function by using **function(n_monks = 18)** to a random network of any size for comparison. #default = 18
    b. Inside the function, I created an adjacency matrix like SAMPLK2 by using **matrix()**.
    c. I then assigned likes and dislikes at random by sampling values using the **sample()** function.

## Part 4: Comparison: Model vs Observations (Answer)
*[See .R script for this part in part_4.R]*

- Both networks have relatively few monks showing strong liking relationships. The generated network is definitively more random and doesn't have the clear clusters or patterns of recipcrocity that were seen in the observed data. In the observed matrix, certain groups of monks had connected groups, which suggested social subgroups. In comparison, the generated network distributed connections more uniformly. The generated network had a similar basic density but lacks the structured social dynamics that exist in real data of connections between people in a community.  

**3. Reflections:**
*[See more in errors_and_lessons.qmd located in errors_and_lessons_files folder]*
- This project strengthened my understanding of:
1. Matrices and lists in applied settings.
2. Row/column operations for network statistics.
3. Functions, control flow, and necessary libraries.
4. The contrast between random vs real-world networks.