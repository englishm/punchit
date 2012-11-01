(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Models", function(exports) {
    return exports.Customer = (function(_super) {

      __extends(Customer, _super);

      function Customer() {
        return Customer.__super__.constructor.apply(this, arguments);
      }

      return Customer;

    })(Backbone.Model);
  });

}).call(this);
