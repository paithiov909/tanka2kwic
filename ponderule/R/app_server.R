#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @noRd
app_server <- function(input, output, session) {
  ponderule_module("ponderuleapp")
}

#' @noRd
ponderule_module <- function(id) {
  corp <- ponderule::tanka
  toks <-
    quanteda::corpus(ponderule::wakati) %>%
    quanteda::tokens(what = "fastestword")
  shiny::moduleServer(
    id,
    function(input, output, session) {
      kwic <-
        shiny::reactive({
          corp %>%
            dplyr::right_join(
              quanteda::kwic(
                toks,
                input$search,
                window = ifelse(is.na(input$window), 5L, input$window)
              ),
              by = c("doc_id" = "docname")
            ) %>%
            dplyr::relocate(
              .data$doc_id,
              .data$from,
              .data$to,
              .data$pre,
              .data$keyword,
              .data$post,
              .data$pattern,
              dplyr::everything()
            )
        })
      output$table <-
        reactable::renderReactable({
          reactable::reactable(
            kwic(),
            filterable = TRUE,
            searchable = TRUE,
            compact = TRUE
          )
        })
    }
  )
}
