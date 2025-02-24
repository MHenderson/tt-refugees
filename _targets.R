library(targets)

tar_option_set(
  packages = c("dplyr", "ggplot2", "ggraph", "ggrepel", "readr", "tibble", "tidygraph", "tidyr"),
  format = "rds"
)

tar_source()

list(
  tar_target(
       name = population,
    command = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-22/population.csv')
  ),
  tar_target(
       name = population_pp,
    command = preprocess(population)
  ),
  tar_target(
       name = tidy_population,
    command = tidy(population_pp)
  ),
  tar_target(
       name = busiest_routes,
    command = busiest_routes_plot(tidy_population)
  ),
  tar_target(
       format = "file",
       name = save_busiest_routes_plot,
    command = ggsave(
          plot = busiest_routes,
      filename = "plot/busiest-routes-plot.png",
            bg = "white",
         width = 5,
        height = 4
    )
  )
)
