busiest_routes_plot <- function(X) {

  X_asylum <- X |>
    filter(name == "asylum_seekers") |>
    mutate(route = paste0(coo_name, "-", coa_name))
  
  busiest_routes <- X_asylum |>
    group_by(route) |>
    summarise(value = sum(value)) |>
    arrange(desc(value)) |>
    head(6)
  
  X_busiest_routes <- X_asylum |>
    filter(route %in% busiest_routes$route)
  
  X_busiest_routes |>
    ggplot(aes(year, value)) +
    geom_line(aes(colour = route)) +
    theme(legend.position = "none") +
    geom_text_repel(
      data = function(x) x |> filter(year == "2022-01-01"),
      aes(label = route, colour = route),
      fontface ="plain",
      size = 5,
      direction = "y",
      hjust = 0,
      segment.size = 2,
      segment.alpha = .5,
      segment.linetype = "dotted",
      box.padding = .4,
      segment.curvature = -0.1,
      segment.ncp = 3,
      segment.angle = 20
    ) +
    scale_x_date(
      expand = c(0, 0),
      limits = c(as.Date("2010-01-01"), as.Date("2030-01-01"))
    )

}