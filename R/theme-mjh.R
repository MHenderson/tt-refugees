theme_mjh <- function() {

  font_add_google("Gochi Hand", "gochi")
    
  theme_minimal() %+replace%
    theme(
      axis.title = element_text(family = "gochi", size = 38),
      axis.text = element_text(family = "gochi", size = 28),
      title = element_text(family = "gochi", size = 44)
    )

}