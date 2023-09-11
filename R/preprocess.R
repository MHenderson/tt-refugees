preprocess <- function(X) {
    X |>
      dplyr::mutate(year = as.Date(paste(year, 1, 1, sep = "-")))
}