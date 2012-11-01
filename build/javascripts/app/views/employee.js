(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.Employee = (function(_super) {

      __extends(Employee, _super);

      function Employee() {
        this.render = __bind(this.render, this);

        this.refresh = __bind(this.refresh, this);

        this.updateEmployee = __bind(this.updateEmployee, this);

        this.initialize = __bind(this.initialize, this);
        return Employee.__super__.constructor.apply(this, arguments);
      }

      Employee.prototype.initialize = function() {
        return PunchIt.Events.on("employeePicked", this.updateEmployee);
      };

      Employee.prototype.updateEmployee = function(employee) {
        this.model = employee;
        PunchIt.Session.setEmployeeId(employee.id);
        return this.refresh();
      };

      Employee.prototype.refresh = function() {
        return this.$('.app-name').html(this.model.get('name'));
      };

      Employee.prototype.render = function() {
        return this.refresh();
      };

      return Employee;

    })(Backbone.View);
  });

}).call(this);
