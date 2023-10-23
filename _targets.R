# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline # nolint

# Load packages required to define the pipeline:
library(showtext) # for font_add_google in theme_mjh
library(ggplot2) # for %+replace% in theme_mjh
library(targets)
# library(tarchetypes) # Load other packages as needed. # nolint

font_add_google("Gochi Hand", "gochi")

# Set target options:
tar_option_set(
  packages = c("dplyr", "ggplot2", "ggraph", "ggrepel", "readr", "tibble", "tidygraph", "tidyr"), # packages that your targets need to run
  format = "rds" # default storage format
  # Set other options as needed.
)

# tar_make_clustermq() configuration (okay to leave alone):
options(clustermq.scheduler = "multicore")

# tar_make_future() configuration (okay to leave alone):
# Install packages {{future}}, {{future.callr}}, and {{future.batchtools}} to allow use_targets() to configure tar_make_future() options.

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# source("other_functions.R") # Source other scripts as needed. # nolint

ggplot2::theme_set(theme_mjh())

## Automatically use showtext to render text
showtext_auto()

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
    name = save_busiest_routes_plot,
    command = ggsave(plot = busiest_routes, filename = "plot/busiest-routes-plot.png", bg = "white", width = 5, height = 4),
    format = "file"
  )
)