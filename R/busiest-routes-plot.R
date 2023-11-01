busiest_routes_plot <- function(X) {

  X_asylum <- X |>
    filter(name == "asylum_seekers") |>
    filter(coo_name != "Unknown") |>
    mutate(route = paste0(coo_name, "-", coa_name))
  
  routes <- X_asylum |>
    group_by(route) |>
    summarise(value = last(value)) |>
    arrange(desc(value))
  
  n_labels <- 5
  
  busiest_routes <- routes |>
    head(n_labels)
  
  other_routes <- routes |>
    slice((n_labels + 1):50)
  
  X_busiest_routes <- X_asylum |>
    filter(route %in% busiest_routes$route)
  
  X_other_routes <- X_asylum |>
    filter(route %in% other_routes$route)
  
  plot_short_description <- "Busiest routes for asylum seekers"
  plot_methodology_note <- "Numbers of asylum seekers with known country of origin and application"
  data_credit <- "United Nations High Commissioner for Refugees (UNHCR) Refugee Data Finder"
  plot_credit <- "Matthew Henderson"
  
  ggplot() +
    geom_line(data = X_busiest_routes, mapping = aes(x = year, y = value, colour = route)) +
    geom_line(data = X_other_routes, mapping = aes(x = year, y = value, group = route), linewidth = 0.1, alpha = 0.5) +
    theme(legend.position = "none") +
    geom_text_repel(
      mapping = aes(x = year, y = value, label = route, colour = route),
      data = function(x) X_busiest_routes |> filter(year == "2022-01-01"),
      size = 5,
      direction = "x",
      hjust = 0,
      segment.size = 0,
      box.padding = 0,
      xlim = c(as.Date("2022-03-01"), as.Date("2025-01-01"))
    ) +
    scale_x_date(
      expand = c(0, 0),
      limits = c(as.Date("2010-01-01"), as.Date("2025-01-01"))
    ) +
    labs(
      title = plot_short_description,
      subtitle = plot_methodology_note,
      caption = paste("Data:", data_credit, "\nPlot:", plot_credit)
    )

}