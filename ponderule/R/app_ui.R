#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  shiny::fluidPage(
    golem_add_external_resources(), ## Leave this function for adding external resources.
    shiny::div(
      class = "page-header",
      shiny::h1(
        "ponderule | KWIC (full text search) of 'Kindai-tanka'"
      )
    ),
    shiny::sidebarLayout(
      shiny::sidebarPanel(app_ui_control("ponderuleapp")),
      shiny::mainPanel(app_ui_main("ponderuleapp"))
    ),
    lang = "ja"
  )
}

#' @noRd
app_ui_control <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::numericInput(
      ns("window"),
      "KWIC\u306e\u30b9\u30d1\u30f3",
      value = 5L,
      min = 1L,
      step = 1L
    ),
    shiny::textInput(
      ns("search"),
      "\u691c\u7d22\u8a9e",
      value = "\u3084\u306f\u3089\u304b",
      placeholder = ""
    ),
    shiny::hr(),
    shiny::includeMarkdown(app_sys("README.md")),
    shiny::includeHTML(app_sys("app/include.html"))
  )
}

#' @noRd
app_ui_main <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    reactable::reactableOutput(ns("table"))
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  golem::add_resource_path("www", app_sys("app/www"))
  shiny::tags$head(
    golem::favicon(),
    golem::bundle_resources(
      path = app_sys("app/www"),
      app_title = "ponderule | KWIC (full text search) of 'Kindai-tanka'"
    ),
    metathis::meta_social(
      metathis::meta(),
      title = "ponderule | KWIC (full text search) of 'Kindai-tanka'",
      url = "https://github.com/paithiov909/ponderule/",
      description = "A full text search functionality for a 'Kindai tanka' corpus.",
      twitter_card_type = "summary",
      og_type = "website",
      og_locale = "ja_JP"
    ),
    shiny::includeHTML(app_sys("app/scripts.html"))
  )
}
