(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.EmployeesModal = (function(_super) {

      __extends(EmployeesModal, _super);

      function EmployeesModal() {
        this.render = __bind(this.render, this);

        this.triggerTypeAhead = __bind(this.triggerTypeAhead, this);

        this.initialize = __bind(this.initialize, this);
        return EmployeesModal.__super__.constructor.apply(this, arguments);
      }

      EmployeesModal.prototype.initialize = function() {
        return $('.app-all-employees-typeahead').on("change", this.triggerTypeAhead);
      };

      EmployeesModal.prototype.triggerTypeAhead = function() {
        var $typeAhead;
        $typeAhead = $('input.app-all-employees-typeahead');
        return PunchIt.Events.trigger("employeePicked", this.collection.get($typeAhead.val()));
      };

      EmployeesModal.prototype.render = function() {
        var data,
          _this = this;
        data = [];
        this.collection.each(function(employee) {
          return data.push({
            id: employee.id,
            text: employee.get('name')
          });
        });
        return $('.app-all-employees-typeahead').select2({
          width: "100%",
          placeholder: "Pick yourself",
          data: data
        });
      };

      return EmployeesModal;

    })(Backbone.View);
  });

}).call(this);
