'use strict';

var Q = require('q');
var _ = require('underscore');

var root = module.exports;
var d = global.document;

/**
 * Promise object for DOM
 */
root.dom = function () {
  var dfr = Q.defer();
  d.addEventListener('DOMContentLoaded', function load (ev) {
    ev.target.removeEventListener(ev.type, load);
    dfr.resolve(ev.target);
  }, false);
  return dfr.promise;
};

/**
 * Promise object for XHR GET
 */
root.get = function (uri) {
  var dfr = Q.defer(), xhr = new global.XMLHttpRequest();
  xhr.addEventListener('readystatechange', function (ev) {
    if (4 === ev.target.readyState && 200 === ev.target.status) {
      dfr.resolve(global.JSON.parse(ev.target.responseText));
    }
  });
  xhr.open('GET', uri, true);
  xhr.send();
  return dfr.promise;
};

/**
 * Promise object for Image element
 */
root.img = function (uri) {
  var dfr = Q.defer(), img = d.createElement('img');
  img.addEventListener('error', function error (ev) {
    ev.target.removeEventListener(ev.type, error);
    dfr.reject(new Error(uri));
  });
  img.addEventListener('load', function load (ev) {
    ev.target.removeEventListener(ev.type, load);
    dfr.resolve(uri);
  });
  img.setAttribute('src', uri);
  return dfr.promise;
};

/**
 * Promise object for Promise array
 */
root.preloads = function (uris, type) {
  var dfr = Q.defer(), promises = [];
  _.map(uris, function (uri) { promises.push(type(uri)); });
  Q.all(promises).then(dfr.resolve, dfr.reject);
  return dfr.promise;
};

/**
 * Promise object for timer
 */
root.sleep = function (millisec) {
  var dfr = Q.defer(), timeoutId;
  timeoutId = global.setTimeout(function () {
    global.clearTimeout(timeoutId);
    dfr.resolve(millisec);
  }, millisec);
  return dfr.promise;
};

/**
 * Shorthand for DOM element remover
 */
root.removeElement = function (el) {
  el.parentNode.removeChild(el);
};

/**
 * lazy
 */
root.lazy = function (millisec, callback) {
  var id, that = this;
  id = global.setTimeout(function () {
    global.clearTimeout(id);
    callback.apply(that);
  }, millisec);
};

/**
 * Polyfill for `animationstart`
 */
root.animationstart = function () {
  var prefixes = {
    'WebkitAnimation': 'webkitAnimationStart',
    'MozAnimation': 'animationstart',
    'animation': 'animationstart'
  };
  return prefixes[global.Modernizr.prefixed('animation')];
};

/**
 * Polyfill for `animationiteration`
 */
root.animationstart = function () {
  var prefixes = {
    'WebkitAnimation': 'webkitAnimationIteration',
    'MozAnimation': 'animationiteration',
    'animation': 'animationiteration'
  };
  return prefixes[global.Modernizr.prefixed('animation')];
};

/**
 * Polyfill for `animationend`
 */
root.animationend = function () {
  var prefixes = {
    'WebkitAnimation': 'webkitAnimationEnd',
    'MozAnimation': 'animationend',
    'animation': 'animationend'
  };
  return prefixes[global.Modernizr.prefixed('animation')];
};

/**
 * Polyfill for `transitionend`
 */
root.transitionend = function () {
  var prefixes = {
    'WebkitTransition': 'webkitTransitionEnd',
    'MozTransition': 'transitionend',
    'transition': 'transitionend'
  };
  return prefixes[global.Modernizr.prefixed('transition')];
};

/**
 * Event listener for polyfill events
 */
root.listen = function (target, event, millisec, callback) {
  var m = global.Modernizr;

  if ('animationstart' === event) {
    if (!m.cssanimations) return root.lazy.call(target, millisec, callback);
    target.addEventListener(root.animationstart(), callback, false);
  }

  if ('animationiteration' === event) {
    if (!m.cssanimations) return root.lazy.call(target, millisec, callback);
    target.addEventListener(root.animationiteration(), callback, false);
  }

  if ('animationend' === event) {
    if (!m.cssanimations) return root.lazy.call(target, millisec, callback);
    target.addEventListener(root.animationend(), callback, false);
  }

  if ('transitionend' === event) {
    if (!m.csstransitions) return root.lazy.call(target, millisec, callback);
    target.addEventListener(root.transitionend(), callback, false);
  }

  return root.lazy.call(target, millisec, callback);
};

/**
 * Event listener remover for polyfill events
 */
root.removeListening = function (target, event, func) {
  if ('animationstart' === event) {
    target.removeEventListener(root.animationstart(), func);
  }

  if ('animationiteration' === event) {
    target.removeEventListener(root.animationiteration(), func);
  }

  if ('animationend' === event) {
    target.removeEventListener(root.animationend(), func);
  }

  if ('transitionend' === event) {
    target.removeEventListener(root.transitionend(), func);
  }
};
