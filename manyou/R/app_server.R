#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @noRd
app_server <- function(input, output, session) {
  manyou_module("manyouapp")
}

#' @noRd
manyou_module <- function(id) {
  corp <-
    dplyr::rename(manyou::manyou, doc_id = !!"\u6b4c\u756a\u53f7")
  toks <-
    quanteda::corpus(manyou::wakati) %>%
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
