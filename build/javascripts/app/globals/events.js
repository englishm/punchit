(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt", function(exports) {
    return exports.Events = (function(_super) {

      __extends(Events, _super);

      function Events() {
        return Events.__super__.constructor.apply(this, arguments);
      }

      return Events;

    })(Backbone.Events);
  });

}).call(this);
