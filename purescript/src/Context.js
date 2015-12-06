"use strict";

// module Context

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
