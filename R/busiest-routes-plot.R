busiest_routes_plot <- function(X) {

  X_asylum <- X |>
    filter(name == "asylum_seekers") |>
    filter(coo_name != "Unknown") |>
    mutate(route = paste0(coo_name, "-", coa_name))
  
  routes <- X_asylum |>
    group_by(route) |>
    summarise(value = sum(value)) |>
    arrange(desc(value))
  
  busiest_routes <- routes |>
    head(10)
  
  other_routes <- routes |>
    slice(11:50)
  
  X_busiest_routes <- X_asylum |>
    filter(route %in% busiest_routes$route)
  
  X_other_routes <- X_asylum |>
    filter(route %in% other_routes$route)
  
  ggplot() +
    geom_line(data = X_busiest_routes, mapping = aes(x = year, y = value, colour = route)) +
    geom_line(data = X_other_routes, mapping = aes(x = year, y = value, group = route), alpha = 0.2) +
    theme(legend.position = "none") +
    geom_text_repel(
      mapping = aes(x = year, y = value, label = route, colour = route),
      data = function(x) X_busiest_routes |> filter(year == "2022-01-01"),
      fontface ="plain",
      size = 5,
      direction = "y",
      hjust = 0,
      segment.size = 0,
      box.padding = .1
    ) +
    scale_x_date(
      expand = c(0, 0),
      limits = c(as.Date("2010-01-01"), as.Date("2025-01-01"))
    )

}