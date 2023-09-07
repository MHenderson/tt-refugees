library(dplyr)
library(ggplot2)
library(ggrepel)
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

afg_asylum <- X_tidy |>
  filter(coo_name == "Afghanistan") |>
  filter(name == "asylum_seekers")

label_data <- afg_asylum |> filter(year == "2021-01-01")

ggplot(afg_asylum, aes(year, value)) +
  geom_line(aes(colour = coa_name)) +
  theme(legend.position = "none") +
  geom_text_repel(
    aes(label = coa_name), data = label_data,
    fontface ="plain", color = "black", size = 3
  )

ggsave(filename = "plot/plot_002.png", bg = "white", width = 10, height = 8)
