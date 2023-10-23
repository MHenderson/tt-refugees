busiest_routes_plot <- function(X) {
  X_asylum <- X |>
    filter(name == "asylum_seekers") |>
    mutate(route = paste0(coo_name, "-", coa_name))
  
  busiest_routes <- X_asylum |>
    group_by(route) |>
    summarise(value = sum(value)) |>
    arrange(desc(value)) |>
    head(10)
  
  X_busiest_routes <- X_asylum |>
    filter(route %in% busiest_routes$route)
  
  X_busiest_routes |>
    ggplot(aes(year, value)) +
    geom_line(aes(colour = route)) +
    theme(legend.position = "none") +
    geom_text_repel(
      data = function(x) x |> filter(year == "2020-01-01"),
      aes(label = route),
      fontface ="plain",
      color = "black",
      size = 3
    )
}