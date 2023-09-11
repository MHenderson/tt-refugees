afg_asylum_plot <- function(X) {
   X |>
        dplyr::filter(coo_name == "Afghanistan") |>
        dplyr::filter(name == "asylum_seekers") |>
        ggplot2::ggplot(aes(year, value)) +
          ggplot2::geom_line(ggplot2::aes(colour = coa_name)) +
          ggplot2::theme(legend.position = "none") +
          ggrepel::geom_text_repel(
            ggplot2::aes(label = coa_name), data = function(x) x |> filter(year == "2021-01-01"),
            fontface ="plain", color = "black", size = 3
          )
}