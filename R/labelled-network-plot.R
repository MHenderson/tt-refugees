edge_data <- function(X, countries) {

  X |>
    dplyr::filter(coo_name %in% countries, coa_name %in% countries) |>
    dplyr::filter(name == "refugees") |>
    dplyr::filter(year == "2021-01-01") |>
    dplyr::select(from = coo_name, to = coa_name, refugees = value) |>
    dplyr::filter(from != to) |>
    dplyr::filter(refugees != 0)

}

network_data <- function(X) {
  country_subset <- sample(unique(c(X$coo_name, X$coa_name)), 10)
  edges <- edge_data(X, country_subset)
  nodes <- data.frame(name = unique(c(edges$from, edges$to)))
  tidygraph::tbl_graph(nodes, edges)
}

labelled_network_plot <- function(X) {

 ggraph::ggraph(X, layout = 'linear', circular = TRUE) + 
   ggraph::geom_edge_arc(ggplot2::aes(colour = refugees)) +
   ggraph::geom_node_label(ggplot2::aes(label = name)) +
   ggplot2::coord_fixed()
 
}

#tidy_population <- targets::tar_read(tidy_population)

set.seed(1)
X <- network_data(tidy_population)
labelled_network_plot(X)

