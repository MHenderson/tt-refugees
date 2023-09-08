# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline # nolint

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed. # nolint

# Set target options:
tar_option_set(
  packages = c("dplyr", "ggplot2", "ggrepel", "readr", "tibble", "tidyr"), # packages that your targets need to run
  format = "rds" # default storage format
  # Set other options as needed.
)

# tar_make_clustermq() configuration (okay to leave alone):
options(clustermq.scheduler = "multicore")

# tar_make_future() configuration (okay to leave alone):
# Install packages {{future}}, {{future.callr}}, and {{future.batchtools}} to allow use_targets() to configure tar_make_future() options.

# Run the R scripts in the R/ folder with your custom functions:
# tar_source()
# source("other_functions.R") # Source other scripts as needed. # nolint

list(
  tar_target(
    name = population,
    command = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-22/population.csv')
  ),
  tar_target(
    name = population_pp,
    command = population |> mutate(year = as.Date(paste(year, 1, 1, sep = "-")))
  ),
  tar_target(
    name = tidy_population,
    command = population_pp |> pivot_longer(refugees:hst)
  ),
  tar_target(
    name = test_plot,
    command = ggplot(data = population) + geom_point(aes(x = year, y = asylum_seekers))
  ),
  tar_target(
    name = save_test_plot,
    command = ggsave(plot = test_plot, filename = "plot/test-plot.png", bg = "white", width = 10, height = 8),
    format = "file"
  ),
  tar_target(
    name = afg_aus_plot,
    command = {
      tidy_population |>
        filter(coo_name == "Afghanistan") |>
        filter(coa_name == "Australia") |>
        ggplot() +
          geom_line(aes(year, value, colour = name))
    }
  ),
  tar_target(
    name = save_afg_aus_plot,
    command = ggsave(plot = afg_aus_plot, filename = "plot/afg-aus-plot.png", bg = "white", width = 10, height = 8),
    format = "file"
  ),
  tar_target(
    name = afg_asylum_plot,
    command = {
      tidy_population |>
        filter(coo_name == "Afghanistan") |>
        filter(name == "asylum_seekers") |>
        ggplot(aes(year, value)) +
          geom_line(aes(colour = coa_name)) +
          theme(legend.position = "none") +
          geom_text_repel(
            aes(label = coa_name), data = function(x) x |> filter(year == "2021-01-01"),
            fontface ="plain", color = "black", size = 3
          )
    }
  ),
  tar_target(
    name = save_afg_asylum_plot,
    command = ggsave(plot = afg_asylum_plot, filename = "plot/afg-asylum-plot.png", bg = "white", width = 10, height = 8),
    format = "file"
  )
)