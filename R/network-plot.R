#network_plot <- function(X) {
 X <- targets::tar_read(tidy_population) 
 
 country_subset <- c("Afghanistan", "Iraq", "Palestine", "Rwanda", "United States of America", "Australia", "United Kingdom")
 
 X_subset <- X |>
   filter(coo_name %in% country_subset, coa_name %in% country_subset) |>
   filter(name == "refugees") |>
   filter(year == "2021-01-01")

 nodes <- data.frame(name = unique(c(X_subset$coo_name, X_subset$coa_name)))
 edges <- expand.grid(from = nodes$name, to = nodes$name)
 
 X_graph <- tbl_graph(nodes, edges)
 
 
 
 #}