edge_data <- function(X, countries) {

  X |>
    filter(coo_name %in% countries, coa_name %in% countries) |>
    filter(name == "refugees") |>
    filter(year == "2021-01-01") |>
    select(from = coo_name, to = coa_name, refugees = value) |>
    filter(from != to) |>
    filter(refugees != 0)

}

simple_network_plot <- function(X) {

 country_subset <- sample(unique(c(X$coo_name, X$coa_name)), 30)

 edges <- edge_data(X, country_subset)
 
 nodes <- data.frame(name = unique(c(edges$from, edges$to)))
 
 X_graph <- tbl_graph(nodes, edges)
 
 ggraph(X_graph, layout = 'linear', circular = TRUE) + 
   geom_edge_arc(aes(width = refugees)) +
   coord_fixed()
 
}
 