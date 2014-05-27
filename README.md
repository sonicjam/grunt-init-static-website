grunt-init-static-website
=========================

静的 web サイト開発用 grunt スケルトン

必要環境
--------

* [Node.js](http://nodejs.org/) v0.10 以上
* [GraphicsMagick](http://www.graphicsmagick.org/) CSS スプライト用画像生成タスク ([grunt-spritesmith](https://github.com/Ensighten/grunt-spritesmith)) に必要
* [grunt-init](http://gruntjs.com/project-scaffolding)

インストール
------------

`grunt-init` コマンドがない場合は `npm` からインストール:

```
npm install -g grunt-init
```

続いてこのスケルトンリポジトリを `git clone` で `~/.grunt-init` 配下へダウンロード:

```
git clone git://github.com/sonicjam/grunt-init-static-website.git ~/.grunt-init/static-website
```

プロジェクト開始時
------------------

初回にプロジェクト用のディレクトリ内で次のコマンドを実行:

```
grunt-init static-website
npm install
```

コンパイルコマンド:

```
grunt
```

監視コマンド:

```
grunt listen
```

ルール
------

* `src` ディレクトリ下のファイルを編集する。他はさわらない。
* `src` 下のディレクトリ構成は自由。
* ただし `vendor` ディレクトリの中に jQuery や normalize.css 等のライブラリを格納する。
* Sass や HTML のインクルード用ファイルは必ず `_` を接頭辞とする。

License
-------

Distributed under the [Unlicense](http://unlicense.org/).
