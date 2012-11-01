(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Customers = (function(_super) {

      __extends(Customers, _super);

      function Customers() {
        return Customers.__super__.constructor.apply(this, arguments);
      }

      Customers.prototype.model = PunchIt.Models.Customer;

      Customers.prototype.url = "" + PunchIt.Session.baseURL + "/customers";

      return Customers;

    })(Backbone.Collection);
  });

}).call(this);
