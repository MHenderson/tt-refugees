preprocess <- function(X) {
  
  replacements <- c("United States of America" = "USA", 
                    "Venezuela \\(Bolivarian Republic of\\)" = "Venezuela",
                    "United Kingdom of Great Britain and Northern Ireland" = "UK",
                    "Netherlands \\(Kingdom of the\\)" = "Netherlands")
  
    X |>
      dplyr::mutate(
        year = as.Date(paste(year, 1, 1, sep = "-"))
      ) |>
      dplyr::mutate(
        coo_name = stringr::str_replace_all(coo_name, replacements)
      ) |>
      dplyr::mutate(
        coa_name = stringr::str_replace_all(coa_name, replacements)
      )

}