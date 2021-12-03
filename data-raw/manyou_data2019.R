require(magrittr)

manyou <-
  readxl::read_xlsx("data-raw/manyou_data2019/manyou_data_utf8.xlsx") %>%
  dplyr::mutate(歌番号 = as.factor(歌番号))

# chimei <-
#  readxl::read_xlsx("data-raw/manyou_data2019/manyou_timei.xlsx", skip = 4L, col_names = TRUE) %>%
#  dplyr::select(1:2)

kajin <-
  readr::read_csv("data-raw/manyou_data2019/kazin.txt", skip_empty_rows = TRUE)
jikou <-
  readr::read_csv("data-raw/manyou_data2019/zikou.txt", skip_empty_rows = TRUE)

usethis::use_data(manyou, overwrite = TRUE)
# usethis::use_data(chimei, overwrite = TRUE)
usethis::use_data(kajin, overwrite = TRUE)
usethis::use_data(jikou, overwrite = TRUE)


library(rjavacmecab)
rebuild_tagger("-d /mecab/UniDic-manyo_1603")

# into <- c(
#   "pos1",
#   "pos2",
#   "pos3",
#   "pos4",
#   "cType",
#   "cForm",
#   "lForm",
#   "lemma",
#   "orth",
#   "pron",
#   "orthBase",
#   "pronBase",
#   "goshu",
#   "iType",
#   "iForm",
#   "fType",
#   "fForm",
#   "kana",
#   "kanaBase",
#   "form",
#   "formBase",
#   "iConType",
#   "fConType",
#   "aType",
#   "aConType",
#   "aModeType"
# )

wakati <-
  purrr::set_names(manyou$訓読, manyou$歌番号) %>%
  cmecab(mode = "wakati") %>%
  tibble::enframe(name = "doc_id", value = "text") %>%
  tidyr::unnest("text") %>%
  dplyr::group_by(doc_id) %>%
  dplyr::mutate(text = paste(.data$text, collapse = " ")) %>%
  dplyr::ungroup() %>%
  dplyr::distinct()

usethis::use_data(wakati, overwrite = TRUE)
