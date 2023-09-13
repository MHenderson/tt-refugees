network_data <- function(X) {
  country_subset <- sample(unique(c(X$coo_name, X$coa_name)), 20)
  edges <- edge_data(X, country_subset)
  nodes <- data.frame(name = unique(c(edges$from, edges$to)))
  tidygraph::tbl_graph(nodes, edges)
}

labelled_network_plot <- function(X) {

 ggraph::ggraph(X, layout = "linear") + 
   ggraph::geom_edge_arc(
     mapping = ggplot2::aes(colour = refugees),
     end_cap = circle(0.5, 'cm'),
     arrow = grid::arrow(angle = 30, length = unit(0.20, "inches"), ends = "last", type = "open"),
     edge_width = 1
    ) +
   ggraph::geom_node_point() +
   ggraph::geom_node_text(ggplot2::aes(label = name), angle = 45) +
   ggraph::scale_edge_color_binned() +
   ggplot2::coord_fixed()
 
}
