'use strict';

var Q = require('q');

var tool = require('./toolchain');
var sample = require('./sample_module.coffee');

var d = global.document;

var preloads = [
  '//lorempixel.com/g/1280/1280/',
  '//placekitten.com/g/1280/1280',
  './img/sprite.png'
];

var promises = [
  tool.dom(),
  tool.preloads(preloads, tool.img),
  tool.get('./sample.json'),
  tool.sleep(3000)
];

function done (resp) {
  var messages = resp[2].messages, messages_length = messages.length;
  var kid = new sample.Child();
  var loader = d.querySelector('.loader__mask');
  var message = d.getElementById('message'), thumb = d.getElementById('thumb');
  var inc = 0, ph = 2;

  kid.on('echo', function (msg) {
    tool.listen(message, 'animationend', 400, function animationend (ev) {
      tool.removeListening(message, 'animationend', animationend);
      thumb.className = 'icon-ph0' + ph + ' fade__in';
      message.className = 'fade__in';
      message.innerText = msg;
    });
    message.className = 'fade__out';
    thumb.className = 'icon-ph0' + ph + ' fade__out';
    console.log(ph);
    ph += 1;
    if (ph >= 4) ph = 1;
  });

  global.setInterval(function () {
    kid.say(messages[inc++]);
    if (inc >= messages_length) inc = 0;
  }, 5000);

  tool.listen(loader, 'transitionend', 100, function transitionend (ev) {
    tool.removeListening(loader, 'transitionend', transitionend);
    tool.removeElement(loader);
  });
  loader.className += ' fade__out';
}

function fail (err) {
  console.error('エラー:', err.message);
}

Q.all(promises).then(done, fail);
