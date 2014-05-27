'use strict'

root = module.exports

root.mixOf = (base, mixins...) ->
  class Mixed extends base
  for mixin in mixins by -1
    Mixed::[name] = method for name, method of mixin::
  return Mixed
