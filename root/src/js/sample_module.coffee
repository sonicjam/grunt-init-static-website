'use strict'

{EventEmitter} = require 'events'

tool = require './toolchain.coffee'

root = module.exports

class Parent

  constructor: ->

  set: (prop, val) =>
    @["#{prop}_"] = val

  get: (prop) =>
    return @["#{prop}_"]


class root.Child extends tool.mixOf Parent, EventEmitter

  constructor: ->
    super()
    @msg_ = 'Hello.'

  destroy: =>
    @removeAllListeners()

  say: (msg) =>
    @set 'msg', msg
    @emit 'echo', @get('msg')
