# ACM sigconf 論文テンプレート

[acmart](https://github.com/borisveytsman/acmart) の配布物から、ダブルブラインドの
`sigconf` 投稿に必要なものだけを残したテンプレート。

```
main.tex        # \documentclass と topmatter。本文は src/ に分割
src/
  000header.tex   # パッケージ読み込みと設定
  001symbol.tex   # 論文固有のマクロ（\newcommand）はここに
  002abstract.tex
  010introduction.tex ... 060conclusion.tex
  100appendix.tex
refs.bib        # 参考文献
lib/            # acmart.cls v2.20 + ACM-Reference-Format.bst + LICENSE
sample/         # 公式サンプル (sigconf) — 書き方のリファレンス
.latexmkrc      # lib/ を TEXINPUTS / BSTINPUTS の先頭に置く設定
```

## ビルド

```sh
make           # -> build/main.pdf
make watch     # 保存のたびに再ビルド
make sample    # sample/sigconf.tex をビルド
make clean     # 中間ファイル削除 (PDF は残す)
```

`lib/` を検索パスの先頭に置いているので、TeX Live 側に古い acmart (2024 は
v2.07) が入っていても `lib/` の v2.20 が使われる。`latexmk` を直接叩く場合も
プロジェクトルートか `sample/` から実行すれば `.latexmkrc` が効く。

## 投稿版 (camera ready)

`anonymous, review` を外して `\documentclass[sigconf]{acmart}` にする。
`\setcopyright` / `\acmDOI` / `\acmISBN` などは ACM の rights form のメールに
書かれている値で置き換えること。

## プレプリント

arXiv や内部配布版など ACM に投稿しないものは `nonacm` を付ける。

```latex
\documentclass[sigconf, nonacm]{acmart}
```

「ACM Reference Format」のブロックと著作権表記の脚注が消える。**投稿版・camera
ready では付けないこと** — どちらも ACM の必須要素で、1ページを超える原稿では
acmart.cls が `ACM reference format is mandatory` と警告を出す。

## CI (PDF の共有)

`main` に push すると [.github/workflows/build-pdf.yml](.github/workflows/build-pdf.yml)
が `main.tex` をビルドし、PDF だけを `pdf` ブランチに置く。共同編集者はこの URL を
ブラウザで開けば読める。スマホでも表示できる。

```
https://github.com/<owner>/<repo>/blob/pdf/main.pdf
```

- `pdf` ブランチは毎回 orphan ブランチとして作り直して force push する。PDF は
  差分圧縮が効かずリポジトリが膨らむため、履歴は1コミットしか持たない。
  **`pdf` ブランチにブランチ保護をかけないこと** — force push が弾かれる。
- ビルドに失敗したときは `.log` が Actions の artifact に上がる。
- push が 403 で落ちる場合は Settings → Actions → General → Workflow permissions
  を確認する。
- プライベートリポジトリなら閲覧側も GitHub にログインが必要。GitHub の
  モバイルアプリは PDF 表示が不安定なので、ブラウザで開くよう伝えるとよい。

## 補足

- 引用は BibTeX + `ACM-Reference-Format`。BibLaTeX (`acmnumeric` /
  `acmauthoryear`) を使う場合は upstream から `acm*.bbx` `acm*.cbx`
  `acmdatamodel.dbx` を `lib/` に持ってくる。
- クラスのドキュメント (`acmart.pdf`, `acmguide.pdf`) は同梱していない。
  <https://ctan.org/pkg/acmart> を参照。
- `lib/LICENSE` は acmart の LGPL / LPPL ライセンス。
