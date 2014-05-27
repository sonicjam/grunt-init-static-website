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
      # grunt
      'grunt': '>=0.4.5'

      # Official plugins for grunt
      'grunt-contrib-clean': '>=0.5.0'
      #'grunt-contrib-coffee': '>=0.10.1'
      #'grunt-contrib-compass': '>=0.8.0'
      #'grunt-contrib-compress': '>=0.9.1'
      'grunt-contrib-concat': '>=0.4.0'
      'grunt-contrib-connect': '>=0.7.1'
      'grunt-contrib-copy': '>=0.5.0'
      #'grunt-contrib-cssmin': '>=0.9.0'
      #'grunt-contrib-handlebars': '>=0.8.0'
      #'grunt-contrib-htmlmin': '>=0.3.0'
      #'grunt-contrib-imagemin': '>=0.7.0'
      'grunt-contrib-jade': '>=0.11.0'
      'grunt-contrib-jshint': '>=0.10.0'
      #'grunt-contrib-jst': '>=0.6.0'
      #'grunt-contrib-less': '>=0.11.0'
      #'grunt-contrib-nodeunit': '>=0.4.0'
      #'grunt-contrib-qunit': '>=0.4.0'
      #'grunt-contrib-requirejs': '>=0.4.4'
      'grunt-contrib-sass': '>=0.7.3'
      'grunt-contrib-stylus': '>=0.16.0'
      'grunt-contrib-uglify': '>=0.4.0'
      'grunt-contrib-watch': '>=0.6.1'
      #'grunt-contrib-yuidoc': '>=0.5.2'

      # 3rd party plugins for grunt@0.4.0
      'grunt-bake': '>=0.3.10'
      'grunt-browserify': '>=2.1.0'
      'grunt-coffeelint': '>=0.0.10'
      'grunt-csso': '>=0.6.1'
      #'grunt-docco': '>=0.3.3'
      'grunt-jsonlint': '>=1.0.4'
      #'grunt-markdown': '>=0.6.1'
      'grunt-notify': '>=0.3.0'
      'grunt-spritesmith': '>=1.26.0'
      #'grunt-styleguide': '>=0.2.15'

      # Browserify support libraries
      'coffeeify': '>=0.6.0'
      'deamdify': '>=0.1.1'
      'debowerify': '>=0.7.1'
      'decomponentify': '>=0.0.3'
      'deglobalify': '>=0.2.0'
      'envify': '>=1.2.1'
      'es6ify': '>=1.1.0'
      'liveify': '>=0.4.0'

      # Support libraries
      'q': '>=1.0.1'
      'underscore': '>=1.6.0'

    props.engines =
      'node': '>0.10'
      'npm': '>1.2'


    files = init.filesToCopy props

    init.addLicenseFiles files, props.licenses
    init.copyAndProcess files, props, { noProcess: 'src/img/**' }
    init.writePackageJSON 'package.json', props

    done()
