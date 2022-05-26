library(rjavacmecab)
rebuild_tagger("-d /mecab/UniDic-kindai_1603")

tanka <-
  jsonlite::read_json("data-raw/tanka_20200401.json", simplifyVector = TRUE) %>%
  dplyr::rename(doc_id = id, line = poet) %>%
  dplyr::mutate(doc_id = as.character(doc_id))

wakati <- tanka %>%
  # dplyr::sample_n(1000L) %>%
  dplyr::mutate(line = strj_fill_iter_mark(line)) %>%
  dplyr::mutate(text = strj_rewrite_as_def(line, read_rewrite_def(system.file("def/kyuji.def", package = "rjavacmecab")))) %>%
  dplyr::select(doc_id, text) %>%
  tibble::deframe() %>%
  cmecab(mode = "wakati") %>%
  tibble::enframe(name = "doc_id", value = "text") %>%
  tidyr::unnest("text") %>%
  dplyr::group_by(doc_id) %>%
  dplyr::mutate(text = paste(.data$text, collapse = " ")) %>%
  dplyr::ungroup() %>%
  dplyr::distinct()

usethis::use_data(tanka, overwrite = TRUE)
usethis::use_data(wakati, overwrite = TRUE)
