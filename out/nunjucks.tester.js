// Generated by CoffeeScript 1.9.1
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  module.exports = function(testers) {
    var NunjucksTester;
    return NunjucksTester = (function(superClass) {
      extend(NunjucksTester, superClass);

      function NunjucksTester() {
        return NunjucksTester.__super__.constructor.apply(this, arguments);
      }

      return NunjucksTester;

    })(testers.RendererTester);
  };

}).call(this);
