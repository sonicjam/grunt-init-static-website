'use strict'

# Node.js モジュール読込
path = require 'path'

# LiveReload スニペット読込
lrUtils = require 'grunt-contrib-livereload/lib/utils'
lrSnippet = lrUtils.livereloadSnippet

# LiveReload 用ヘルパー関数
folderMount = (connect, point) ->
  return connect.static path.resolve(point)


#
# Grunt 主要設定
# --------------
module.exports = (grunt) ->

  #
  # Grunt 初期設定オブジェクト (`grunt.initConfig()` の引数として渡す用)
  #
  conf =

    # `package.json` を (`<%= pkg.PROP  %>` として読込)
    pkg: grunt.file.readJSON 'package.json'

    # バナー文字列 (`<%= banner %>` として読込)
    banner: """
      /*!
       * <%= pkg.title || pkg.name %>
       * v<%= pkg.version %> - <%= grunt.template.today('isoDateTime') %>
       */
      """

    # 基本パス設定 (`<%= path.PROP %>` として読込)
    path:
      source: 'src'
      intermediate: '.intermediate'
      publish: 'dist'

    #
    # HTML コンパイルタスク
    #
    # * [grunt-bake](https://github.com/MathiasPaumgarten/grunt-bake)
    #
    bake:
      options:
        content: '<%= path.source %>/meta.json'
        basePath: '<%= path.source %>'
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: [
          '**/!(_)*.html'
        ]
        dest: '<%= path.intermediate %>'
        ext: '.html'

    #
    # CoffeeScript コンパイルタスク
    #
    # * [grunt-contrib-coffee](https://github.com/gruntjs/grunt-contrib-coffee)
    #
    coffee:
      options:
        bare: false
        sourceMap: true
      general:
        expand: true
        cwd: '<%= path.source %>'
        src: [
          '**/*.coffee'
          '**/*.litcofee'
        ]
        dest: '<%= path.intermediate %>'
        ext: '.js'

    #
    # CoffeeScript 静的解析タスク
    #
    # * [grunt-coffeelint](https://github.com/vojtajina/grunt-coffeelint)
    # * [CoffeeLint options](http://www.coffeelint.org/#options)
    #
    coffeelint:
      options:
        indentation: 2
        max_line_length: 80
        camel_case_classes: true
        no_trailing_semicolons:  true
        no_implicit_braces: true
        no_implicit_parens: false
        no_empty_param_list: true
        no_tabs: true
        no_trailing_whitespace: true
        no_plusplus: false
        no_throwing_strings: true
        no_backticks: true
        line_endings: true
        no_stand_alone_at: false
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: [
          '**/*.coffee'
          '**/*.litcoffee'
          '!**/vendor/**/*'
        ]

    #
    # ファイルとディレクトリ削除タスク
    #
    # * [grunt-contrib-clean](https://github.com/gruntjs/grunt-contrib-clean)
    #
    clean:
      options:
        force: true
      intermediate:
        src: '<%= path.intermediate %>'
      publish:
        src: '<%= path.publish %>'

    #
    # ローカルサーバー (Connect) と LiveReload タスク
    #
    # * [grunt-contrib-connect](https://github.com/gruntjs/grunt-contrib-connect)
    # * [grunt-contrib-livereload](https://github.com/gruntjs/grunt-contrib-livereload)
    #
    connect:
      intermediate:
        options:
          port: 50000
          middleware: (connect, options) ->
            return [lrSnippet, folderMount(connect, '.intermediate')]
      publish:
        options:
          port: 50001
          base: '<%= path.publish %>'

    #
    # ファイルコピータスク
    #
    # * [grunt-contrib-copy](https://github.com/gruntjs/grunt-contrib-copy)
    #
    copy:
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: [
          '**/*'
          '!**/*.coffee'
          '!**/*.hbs'
          '!**/*.html'
          '!**/*.jade'
          '!**/*.jst'
          '!**/*.less'
          '!**/*.litcoffee'
          '!**/*.sass'
          '!**/*.scss'
          '!**/*.styl'
          '!img/sprites/**/*'
        ]
        dest: '<%= path.intermediate %>'
      intermediate:
        expand: true
        cwd: '<%= path.intermediate %>'
        src: '**/*'
        dest: '<%= path.publish %>'

     #
     # CSSO による CSS 最適化タスク
     #
     # * [grunt-csso](https://github.com/t32k/grunt-csso)
     #
     csso:
       options:
         restructure: true
       intermediate:
         expand: true
         cwd: '<%= path.intermediate %>'
         src: [
           '**/*.css'
           '!**/*.min.css'
           '!**/*-min.css'
           '!**/vendor/**'
         ]
         dest: '<%= path.publish %>'
         ext: '.min.css'

    #
    # Jade コンパイルタスク
    #
    # * [grunt-contrib-jade](https://github.com/gruntjs/grunt-contrib-jade)
    #
    jade:
      options:
        pretty: true
        data: ->
          return grunt.file.readJSON './src/meta.json'
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: '**/!(_)*.jade'
        dest: '<%= path.intermediate %>'
        ext: '.html'

    #
    # JSHint による JavaScript 静的解析タスク
    #
    # * [grunt-contrib-jshint](https://github.com/gruntjs/grunt-contrib-jshint)
    #
    jshint:
      options:
        jshintrc: '.jshintrc'
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: [
          '**/*.js'
          '!**/vendor/**/*.js'
        ]

    #
    # JSON 静的解析タスク
    #
    # * [grunt-jsonlint](https://github.com/brandonramirez/grunt-jsonlint)
    #
    jsonlint:
      source:
        src: [
          '<%= path.source %>/**/*.json'
          'package.json'
        ]

    #
    # LESS コンパイルタスク
    #
    # * [grunt-contrib-less](https://github.com/gruntjs/grunt-contrib-less)
    #
    less:
      options:
        compass: false
        yuicompress: false
        optimization: null
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: '**/!(_)*.less'
        dest: '<%= path.intermediate %>'
        ext: '.css'

    #
    # メッセージ通知タスク
    #
    # * [grunt-notify](https://github.com/dylang/grunt-notify)
    #
    notify:
      build:
        options:
          title: 'ビルド完了'
          message: 'タスクが正常終了しました。'
      watch:
        options:
          title: '監視開始'
          message: 'ローカルサーバーを起動しました: http://localhost:50000/'

    #
    # Sass / SassyCSS コンパイルタスク
    #
    # * [grunt-contrib-sass](https://github.com/gruntjs/grunt-contrib-sass)
    #
    sass:
      options:
        unixNewlines: true
        compass: true
        noCache: false
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: [
          '**/!(_)*.sass'
          '**/!(_)*.scss'
        ]
        dest: '<%= path.intermediate %>'
        ext: '.css'

    #
    # CSS スプライト作成タスク
    #
    # * [grunt-spritesmith](https://github.com/Ensighten/grunt-spritesmith)
    #
    sprite:
      source:
        src: [
          '<%= path.source %>/img/sprites/*.png'
        ]
        destImg: '<%= path.source %>/img/sprite.png'
        destCSS: '<%= path.source %>/css/_sprites.styl'
        algorithm: 'binary-tree'
        padding: 1

    #
    # Stylus コンパイルタスク
    #
    # * [grunt-contrib-stylus](https://github.com/gruntjs/grunt-contrib-stylus)
    #
    stylus:
      options:
        compress: false
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: '**/!(_)*.styl'
        dest: '<%= path.intermediate %>'
        ext: '.css'

     #
     # UglifyJS による JavaScript 最適化タスク
     #
     # * [grunt-contrib-uglify](https://github.com/gruntjs/grunt-contrib-uglify)
     #
     uglify:
       options:
         preserveComments: false
       intermediate:
         expand: true
         cwd: '<%= path.intermediate %>'
         src: [
           '**/*.js'
           '!**/*.min.js'
           '!**/*-min.js'
           '!**/vendor/**'
         ]
         dest: '<%= path.publish %>'
         ext: '.min.js'

    #
    # ファイル更新監視タスク
    #
    # * [grunt-contrib-watch](https://github.com/gruntjs/grunt-contrib-watch)
    #
    watch:
      options:
        livereload: true
      source:
        files: '<%= path.source %>/**/*'
        tasks: [
          'default'
        ]


  #
  # 実行タスクの順次定義 (`grunt.registerTask tasks.TASK` として登録)
  #
  tasks =
    css: [
      'less'
      'stylus'
      'sass'
      'csso'
    ]
    html: [
      'jade'
      'bake'
    ]
    image: [
      'sprite'
    ]
    js: [
      #'jshint'
      #'coffeelint'
      'coffee'
      'uglify'
    ]
    json: [
      'jsonlint'
    ]
    watcher: [
      'notify:watch'
      'connect'
      'watch'
    ]
    default: [
      'css'
      'html'
      'image'
      'js'
      'json'
      'copy:source'
      'copy:intermediate'
      'notify:build'
    ]


  # Grunt プラグイン読込
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-livereload'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-bake'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-csso'
  grunt.loadNpmTasks 'grunt-jsonlint'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-spritesmith'

  # 初期設定オブジェクトの登録
  grunt.initConfig conf

  # 実行タスクの登録
  grunt.registerTask 'css', tasks.css
  grunt.registerTask 'html', tasks.html
  grunt.registerTask 'image', tasks.image
  grunt.registerTask 'js', tasks.js
  grunt.registerTask 'json', tasks.json
  grunt.registerTask 'watcher', tasks.watcher
  grunt.registerTask 'default', tasks.default
