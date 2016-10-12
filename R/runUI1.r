#' run an interactive shiny User Interface to the graphical model
#'
#' displays a user interface in the browser, allowing users to modify inputs

#' @return nothing
#' @import shiny markdown
#' @export

runUI1 <- function() {

  shiny::runApp(system.file('shiny/coverage1', package='coverage'))
}
