library(dplyr)
library(ggplot2)
library(targets)
library(tidyr)

# tar_make()

X <- tar_read(population)

X <- X |>
  mutate(
    year = as.Date(paste(year, 1, 1, sep = "-"))
  )

X_tidy <- X |>
  pivot_longer(refugees:hst)

XX <- X_tidy |>
  filter(coo_name == "Afghanistan") |>
  filter(coa_name == "Australia")

ggplot(XX) +
  geom_line(aes(year, value, colour = name))

ggsave(filename = "plot/plot_001.png", bg = "white", width = 10, height = 8)
