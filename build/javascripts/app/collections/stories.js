(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Stories = (function(_super) {

      __extends(Stories, _super);

      function Stories() {
        return Stories.__super__.constructor.apply(this, arguments);
      }

      Stories.prototype.model = PunchIt.Models.Story;

      return Stories;

    })(Backbone.Collection);
  });

}).call(this);
