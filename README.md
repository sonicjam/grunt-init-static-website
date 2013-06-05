grunt-init-static-website
=========================

静的 web サイト開発用 grunt スケルトン

インストール
------------

```
git clone git://github.com/sonicjam/grunt-init-static-website.git ~/.grunt-init/static-website
```

プロジェクト開始時
------------------

```
cd /path/to/proj
grunt-init static-website
npm install
grunt
grunt watcher
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
