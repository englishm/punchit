(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Models", function(exports) {
    return exports.Employee = (function(_super) {

      __extends(Employee, _super);

      function Employee() {
        return Employee.__super__.constructor.apply(this, arguments);
      }

      return Employee;

    })(Backbone.Model);
  });

}).call(this);
