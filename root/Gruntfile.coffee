'use strict'

# Node.js モジュール読込
fs = require 'fs'
path = require 'path'


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
        filter: 'isFile'
        dest: '<%= path.publish %>'
        ext: '.html'

    #
    # Browserify JavaScript コンパイルタスク
    #
    # * [grunt-browserify](https://github.com/jmreidy/grunt-browserify)
    #
    browserify:
      options:
        transform: [
          'coffeeify'
          'debowerify'
        ]
      app:
        src: '<%= path.source %>/js/main.js'
        dest: '<%= path.publish %>/js/app.js'

    #
    # CoffeeScript 静的解析タスク
    #
    # * [grunt-coffeelint](https://github.com/vojtajina/grunt-coffeelint)
    # * [CoffeeLint options](http://www.coffeelint.org/#options)
    #
    coffeelint:
      options: JSON.parse fs.readFileSync('.coffeelintrc')
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: [
          '**/*.coffee'
          '**/*.litcoffee'
          '!**/common/**/*'
        ]
        filter: 'isFile'

    #
    # ファイル結合タスク
    #
    # * [grunt-contrib-concat](https://github.com/gruntjs/grunt-contrib-concat)
    #
    concat:
      options:
        separator: ';'
      common:
        src: [
          '<%= path.source %>/js/common/**/*.js'
          '<%= path.source %>/js/socials.js'
        ]
        dest: '<%= path.publish %>/js/common.js'

    #
    # ファイルとディレクトリ削除タスク
    #
    # * [grunt-contrib-clean](https://github.com/gruntjs/grunt-contrib-clean)
    #
    clean:
      options:
        force: true
      publish:
        src: '<%= path.publish %>'

    #
    # ローカルサーバー (Connect) タスク
    #
    # * [grunt-contrib-connect](https://github.com/gruntjs/grunt-contrib-connect)
    #
    connect:
      publish:
        options:
          port: 9000
          protocol: 'http'
          hostname: '*'
          base: '<%= path.publish %>'
          livereload: true

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
          '.htaccess'
          '!**/*.coffee'
          '!**/*.hbs'
          '!**/*.html'
          '!**/*.jade'
          '!**/*.js'
          '!**/*.jst'
          '!**/*.litcoffee'
          '!**/*.sass'
          '!**/*.scss'
          '!**/*.styl'
          '!meta.json'
          '!img/sprites/**/*'
        ]
        dest: '<%= path.publish %>'

     #
     # CSSO による CSS 最適化タスク
     #
     # * [grunt-csso](https://github.com/t32k/grunt-csso)
     #
     csso:
       options:
         restructure: true
       publish:
         expand: true
         cwd: '<%= path.publish %>'
         src: [
           '**/*.css'
           '!**/*.min.css'
           '!**/*-min.css'
           '!**/common/**'
         ]
         filter: 'isFile'
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
        filter: 'isFile'
        dest: '<%= path.publish %>'
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
          '!**/common/**/*.js'
        ]
        filter: 'isFile'

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
        filter: 'isFile'

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
        filter: 'isFile'
        dest: '<%= path.publish %>'
        ext: '.css'

    #
    # CSS スプライト作成タスク
    #
    # * [grunt-spritesmith](https://github.com/Ensighten/grunt-spritesmith)
    #
    sprite:
      source:
        src: [
          './src/img/sprites/*.png'
        ]
        destImg: './dist/img/sprite.png'
        destCSS: './dist/css/sprite.css'
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
        'include css': false
      source:
        expand: true
        cwd: '<%= path.source %>'
        src: '**/!(_)*.styl'
        filter: 'isFile'
        dest: '<%= path.publish %>'
        ext: '.css'

     #
     # UglifyJS による JavaScript 最適化タスク
     #
     # * [grunt-contrib-uglify](https://github.com/gruntjs/grunt-contrib-uglify)
     #
     uglify:
       options:
         sourceMap: true
         preserveComments: false
       publish:
         expand: true
         cwd: '<%= path.publish %>'
         src: [
           '**/*.js'
           '!**/*.min.js'
           '!**/*-min.js'
           '!**/common/**'
         ]
         filter: 'isFile'
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
      css:
        files: [
          '<%= path.source %>/**/*.css'
          '<%= path.source %>/**/*.s(a|c)ss'
          '<%= path.source %>/**/*.styl'
        ]
        tasks: [
          #'sass'
          'stylus'
          'csso'
          'notify:build'
        ]
      html:
        files: [
          '<%= path.source %>/**/*.html'
          '<%= path.source %>/**/*.jade'
        ]
        tasks: [
          'jade'
          'bake'
          'notify:build'
        ]
      image:
        files: [
          '<%= path.source %>/**/img/**/*'
        ]
        tasks: [
          'sprite'
          'copy'
          'csso'
          'notify:build'
        ]
      js:
        files: [
          '<%= path.source %>/**/*.coffee'
          '<%= path.source %>/**/*.js'
          '<%= path.source %>/**/*.json'
          '<%= path.source %>/**/*.litcoffee'
        ]
        tasks: [
          'jsonlint'
          'jshint'
          'coffeelint'
          'browserify'
          'uglify'
          'notify:build'
        ]


  #
  # 実行タスクの順次定義 (`grunt.registerTask tasks.TASK` として登録)
  #
  tasks =
    listen: [
      'notify:watch'
      'connect'
      'watch'
    ]
    default: [
      'clean'
      'jsonlint'    # JavaScript 静的解析
      'jshint'
      'coffeelint'
      #'sass'        # CSS プリプロセス
      'stylus'
      'jade'        # HTML プリプロセス
      'bake'
      'concat'      # JavaScript 結合
      'browserify'
      'sprite'      # 画像スプライト化
      'copy'        # その他コピー
      'csso'        # コンパイル
      'uglify'
      'notify:build'
    ]


  # Grunt プラグイン読込
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-bake'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-csso'
  grunt.loadNpmTasks 'grunt-jsonlint'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-spritesmith'

  # 初期設定オブジェクトの登録
  grunt.initConfig conf

  # 実行タスクの登録
  grunt.registerTask 'listen', tasks.listen
  grunt.registerTask 'default', tasks.default
