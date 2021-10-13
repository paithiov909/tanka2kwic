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
