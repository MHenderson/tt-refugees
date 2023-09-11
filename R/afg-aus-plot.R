afg_aus_plot <- function(X) {
    X |>
        dplyr::filter(coo_name == "Afghanistan") |>
        dplyr::filter(coa_name == "Australia") |>
        ggplot2::ggplot() +
          ggplot2::geom_line(ggplot2::aes(year, value, colour = name))
}