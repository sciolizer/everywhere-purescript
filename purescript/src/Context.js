"use strict";

// module Context

if (typeof window !== "undefined") {
  exports.display = function(text) {
    return function() {
      window.context.display(text);
    };
  };
  exports.onInput = function(handler) {
    return function() {
      window.context.onInput(function (ln) { return handler(ln)(); });
    };
  };
} else {
  var readline = require('readline');

  var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  exports.display = function(text) {
    return function() {
      console.log(text);
    };
  };
  exports.onInput = function(handler) {
    return function() {
      rl.on('line', function (ln) { return handler(ln)(); });
    };
  };
}
