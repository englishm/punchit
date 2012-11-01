(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.WeekSummary = (function(_super) {

      __extends(WeekSummary, _super);

      function WeekSummary() {
        this.employeeId = __bind(this.employeeId, this);

        this.render = __bind(this.render, this);

        this.refresh = __bind(this.refresh, this);

        this.initialize = __bind(this.initialize, this);
        return WeekSummary.__super__.constructor.apply(this, arguments);
      }

      WeekSummary.prototype.initialize = function() {
        var saturday, sunday;
        this.collection.on("change", this.refresh);
        this.collection.on("reset", this.refresh);
        this.collection.on("remove", this.refresh);
        this.collection.on("add", this.refresh);
        sunday = '2012-10-28';
        saturday = '2012-11-03';
        this.collection.url = "/employees/" + (this.employeeId()) + "/punches?date.gte=" + sunday + "&date.lte=" + saturday;
        return this.collection.loadPunches();
      };

      WeekSummary.prototype.refresh = function() {
        var billable, nonbillable;
        billable = this.collection.billable();
        nonbillable = this.collection.nonbillable();
        this.$('.progress .app-hours-billable').width("" + (billable * 2) + "%");
        this.$('.progress .app-hours-non-billable').width("" + (nonbillable * 2) + "%");
        this.$('.badge.app-hours-billable').text(billable);
        return this.$('.badge.app-hours-non-billable').text(nonbillable);
      };

      WeekSummary.prototype.render = function() {
        return this.refresh();
      };

      WeekSummary.prototype.employeeId = function() {
        return PunchIt.Session.getEmployeeId();
      };

      return WeekSummary;

    })(Backbone.View);
  });

}).call(this);
