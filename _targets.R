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
    name = test,
    command = test_plot(population_pp)
  ),
  tar_target(
    name = save_test_plot,
    command = ggsave(plot = test, filename = "plot/test-plot.png", bg = "white", width = 5, height = 4),
    format = "file"
  ),
  tar_target(
    name = afg_aus_X,
    command = afg_aus_data(tidy_population)
  ),
  tar_target(
    name = afg_aus,
    command = afg_aus_plot(afg_aus_X)
  ),
  tar_target(
    name = save_afg_aus_plot,
    command = ggsave(plot = afg_aus, filename = "plot/afg-aus-plot.png", bg = "white", width = 5, height = 4),
    format = "file"
  ),
  tar_target(
    name = afg_asylum_X,
    command = afg_asylum_data(tidy_population)
  ),
  tar_target(
    name = afg_asylum,
    command = afg_asylum_plot(afg_asylum_X)
  ),
  tar_target(
    name = save_afg_asylum_plot,
    command = ggsave(plot = afg_asylum, filename = "plot/afg-asylum-plot.png", bg = "white", width = 5, height = 4),
    format = "file"
  ),
  tar_target(
    name = simple_network,
    command = simple_network_plot(tidy_population)
  ),
  tar_target(
    name = save_simple_network_plot,
    command = ggsave(plot = simple_network, filename = "plot/simple-network-plot.png", bg = "white", width = 5, height = 4),
    format = "file"
  ),
  tar_target(
    name = labelled_network,
    command = tidy_population |> network_data() |> labelled_network_plot()
  ),
  tar_target(
    name = save_labelled_network_plot,
    command = ggsave(plot = labelled_network, filename = "plot/labelled-network-plot.png", bg = "white", width = 5, height = 4),
    format = "file"
  )
)