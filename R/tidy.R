tidy <- function(X) {
    X |>
      tidyr::pivot_longer(refugees:hst)
}