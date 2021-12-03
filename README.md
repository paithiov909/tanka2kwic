# manyou

<!-- badges: start -->
<!-- badges: end -->

> Text Data of the [Manyoshu](https://en.wikipedia.org/wiki/Man%27y%C5%8Dsh%C5%AB)

## このRパッケージについて

[manyou](https://github.com/paithiov909/manyou)は、万葉集をKWIC検索するためのShinyアプリです。

使用しているデータとしては、吉村誠氏が[サイト](https://c-able.ne.jp/~y_mura/)で頒布している「万葉集テキストデータ（UTF-8）」をそのまま利用しています。

KWIC検索するテキストとしては、上記のデータの「訓読」についてMeCabと[上代（万葉集）UniDic](https://ccd.ninjal.ac.jp/unidic/download_all#unidic_manyo)を利用して短単位の分かち書きにしたデータを使用しています。

## 「万葉集テキストデータ（UTF-8）」について

[data-raw/manyou_data2019](https://github.com/paithiov909/manyou/tree/main/data-raw/manyou_data2019)にそのまま展開しています。データの内容については、[説明.txt](https://github.com/paithiov909/manyou/blob/main/data-raw/manyou_data2019/説明.txt)を参照してください。

## Licence

GPL (>= 3).
