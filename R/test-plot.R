test_plot <- function(X) {
  ggplot(data = X) +
    geom_point(ggplot2::aes(x = year, y = asylum_seekers)) +
    labs(title = "Number of asylum seekers")
}