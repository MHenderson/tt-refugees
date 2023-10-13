theme_mjh <- function(base_family = "gochi", base_size = 11.5) {

  ret <- theme_minimal(base_family = base_family, base_size = base_size)
  
  ret + theme()

}