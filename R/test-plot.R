test_plot <- function(X) {
  ggplot2::ggplot(data = X) +
    ggplot2::geom_point(ggplot2::aes(x = year, y = asylum_seekers))
}