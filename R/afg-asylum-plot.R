afg_asylum_data <- function(X) {
  X |>
    filter(coo_name == "Afghanistan") |>
    filter(name == "asylum_seekers")
}

afg_asylum_plot <- function(X) {
  ggplot(X, aes(year, value)) +
    geom_line(aes(colour = coa_name)) +
    theme(legend.position = "none") +
    geom_text_repel(
      data = function(x) x |> filter(year == "2021-01-01"),
      aes(label = coa_name),
      fontface ="plain",
      color = "black",
      size = 3
    )
}