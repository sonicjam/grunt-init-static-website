'use strict'

exports.description = """
  静的 web サイト開発用 grunt スケルトン
  """

exports.warnOn = 'Gruntfile.coffee'

exports.template = (grunt, init, done) ->

  options = {}
  prompts = [
    init.prompt 'name'
    init.prompt 'version', '0.0.0'
    init.prompt 'description'
    init.prompt 'author_name'
    init.prompt 'author_email'
    init.prompt 'licenses'
  ]

  init.process options, prompts, (err, props) ->

    props.dependencies = {}

    props.peerDependencies = {}

    props.devDependencies =
      # grunt@0.4.1
      'grunt': '>=0.4.1'

      # Official plugins for grunt@0.4.0
      'grunt-contrib-clean': '>=0.4.1'
      'grunt-contrib-coffee': '>=0.7.0'
      #'grunt-contrib-compass': '>=0.2.0'
      #'grunt-contrib-compress': '>=0.5.2'
      #'grunt-contrib-concat': '>=0.3.0'
      'grunt-contrib-connect': '>=0.3.0'
      'grunt-contrib-copy': '>=0.4.1'
      #'grunt-contrib-cssmin': '>=0.6.1'
      #'grunt-contrib-handlebars': '>=0.5.9'
      #'grunt-contrib-htmlmin': '>=0.1.3'
      #'grunt-contrib-imagemin': '>=0.1.4'
      'grunt-contrib-jade': '>=0.6.0'
      #'grunt-contrib-jasmine': '>=0.4.2'
      'grunt-contrib-jshint': '>=0.6.0'
      #'grunt-contrib-jst': '>=0.5.0'
      'grunt-contrib-less': '>=0.5.2'
      'grunt-contrib-livereload': '>=0.1.2'
      #'grunt-contrib-nodeunit': '>=0.2.0'
      #'grunt-contrib-qunit': '>=0.2.1'
      #'grunt-contrib-requirejs': '>=0.4.1'
      'grunt-contrib-sass': '>=0.3.0'
      'grunt-contrib-stylus': '>=0.5.0'
      'grunt-contrib-uglify': '>=0.2.2'
      'grunt-contrib-watch': '>=0.4.4'
      #'grunt-contrib-yuidoc': '>=0.4.0'

      # 3rd party plugins for grunt@0.4.0
      'grunt-bake': '>=0.1.0'
      #'grunt-browserify': '>=0.2.2'
      #'grunt-coffeeify': '>=0.1.3'
      'grunt-coffeelint': '>=0.0.6'
      'grunt-csso': '>=0.5.0'
      #'grunt-docco': '>=0.2.0'
      #'grunt-es6-module-transpiler': '>=0.3.0'
      'grunt-jsonlint': '>=1.0.0'
      #'grunt-markdown': '>=0.2.0'
      #'grunt-mocha': '>0.3.4'
      'grunt-notify': '>=0.2.4'
      #'grunt-reduce': 'git://github.com/japboy/grunt-reduce.git'
      #'grunt-simple-mocha': '>=0.4.0'
      #'grunt-styleguide': '>=0.2.6'
      #'grunt-testem': '>=0.3.4'

      # Test utilities
      #'chai': '>1.5'
      #'sinon': '>1.6'

      # Support libraries
      #'q': '>=0.9.2'

    props.engines =
      'node': '>0.10'
      'npm': '>1.2'


    files = init.filesToCopy props

    init.addLicenseFiles files, props.licenses
    init.copyAndProcess files, props
    init.writePackageJSON 'package.json', props

    done()
