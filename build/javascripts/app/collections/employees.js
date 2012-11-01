(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Employees = (function(_super) {

      __extends(Employees, _super);

      function Employees() {
        return Employees.__super__.constructor.apply(this, arguments);
      }

      Employees.prototype.model = PunchIt.Models.Employee;

      Employees.prototype.url = "" + PunchIt.Session.baseURL + "/employees?active=true";

      return Employees;

    })(Backbone.Collection);
  });

}).call(this);
