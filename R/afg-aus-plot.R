afg_aus_data <- function(X) {
  X |>
    filter(coo_name == "Afghanistan") |>
    filter(coa_name == "Australia")
}

afg_aus_plot <- function(X) {
  ggplot(X) +
    geom_line(aes(year, value, colour = name))
}