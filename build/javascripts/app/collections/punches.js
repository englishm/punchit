(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Punches = (function(_super) {

      __extends(Punches, _super);

      function Punches() {
        this.nextStartTime = __bind(this.nextStartTime, this);

        this.nonbillable = __bind(this.nonbillable, this);

        this.billable = __bind(this.billable, this);

        this.activePunch = __bind(this.activePunch, this);

        this.loadStories = __bind(this.loadStories, this);

        this.loadPunches = __bind(this.loadPunches, this);

        this.initialize = __bind(this.initialize, this);
        return Punches.__super__.constructor.apply(this, arguments);
      }

      Punches.prototype.model = PunchIt.Models.Punch;

      Punches.prototype.url = "" + PunchIt.Session.baseURL + "/punches";

      Punches.prototype.initialize = function() {
        return this.projects = arguments[1].projects;
      };

      Punches.prototype.loadPunches = function() {
        return this.fetch({
          success: this.loadStories
        });
      };

      Punches.prototype.loadStories = function() {
        var projects,
          _this = this;
        projects = {};
        this.each(function(punch) {
          var project, projectId;
          projectId = punch.get('project_id');
          project = _this.projects.get(projectId);
          return projects[projectId] = project;
        });
        return _(projects).each(function(project) {
          return project.fetchStories();
        });
      };

      Punches.prototype.activePunch = function() {
        var _this = this;
        return this.find(function(punch) {
          return punch.active;
        });
      };

      Punches.prototype.billable = function() {
        var billableTotal,
          _this = this;
        billableTotal = 0;
        this.each(function(punch) {
          var project;
          project = _this.projects.get(punch.get('project_id'));
          if (project && project.get('billable')) {
            return billableTotal = billableTotal + punch.duration();
          }
        });
        return billableTotal;
      };

      Punches.prototype.nonbillable = function() {
        var nonBillableTotal,
          _this = this;
        nonBillableTotal = 0;
        this.each(function(punch) {
          var project;
          project = _this.projects.get(punch.get('project_id'));
          if (project && !project.get('billable') && !project.get('personal')) {
            return nonBillableTotal = nonBillableTotal + punch.duration();
          }
        });
        return nonBillableTotal;
      };

      Punches.prototype.nextStartTime = function(date) {
        var lastPunch,
          _this = this;
        lastPunch = this.max(function(punch) {
          return punch.get('stop');
        });
        if (lastPunch) {
          return lastPunch.get('stop');
        } else {
          return 9;
        }
      };

      return Punches;

    })(Backbone.Collection);
  });

}).call(this);
