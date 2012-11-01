(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.Punches = (function(_super) {

      __extends(Punches, _super);

      function Punches() {
        this.refresh = __bind(this.refresh, this);

        this.updateViews = __bind(this.updateViews, this);

        this.addModel = __bind(this.addModel, this);

        this.employeeId = __bind(this.employeeId, this);

        this.updatePunches = __bind(this.updatePunches, this);

        this.initialize = __bind(this.initialize, this);
        return Punches.__super__.constructor.apply(this, arguments);
      }

      Punches.prototype.initialize = function(_arg) {
        this.projects = _arg.projects, this.calendarView = _arg.calendarView;
        this.collection.url = "/employees/" + (this.employeeId()) + "/punches";
        this.datePicker = $('.app-punch-date');
        this.datePicker.on('changeDate', this.updatePunches);
        PunchIt.Events.on("changed:employeeId", this.updatePunches);
        this.collection.on('reset', this.refresh);
        this.collection.on('add', this.updateViews);
        this.views = {};
        return this.updatePunches();
      };

      Punches.prototype.updatePunches = function() {
        this.collection.url = "" + PunchIt.Session.baseURL + "/employees/" + (this.employeeId()) + "/punches?date.gte=" + (this.datePicker.val()) + "&date.lte=" + (this.datePicker.val());
        this.collection.loadPunches();
        return this.collection.url = "" + PunchIt.Session.baseURL + "/employees/" + (this.employeeId()) + "/punches";
      };

      Punches.prototype.employeeId = function() {
        return PunchIt.Session.getEmployeeId();
      };

      Punches.prototype.addModel = function(model) {
        return this.collection.add(model);
      };

      Punches.prototype.updateViews = function() {
        var _this = this;
        this.collection.each(function(punch) {
          var start, stop;
          if (!_this.views[punch.cid]) {
            _this.views[punch.cid] = new PunchIt.Views.Punch({
              model: punch,
              projects: _this.projects
            });
            _this.views[punch.cid].render();
            start = punch.get('start');
            stop = punch.get('stop');
            return _this.calendarView.addEditablePunch($(_this.views[punch.cid].el), start, stop);
          }
        });
        return _(this.collection.pluck('project_id')).uniq(function(id) {
          return _this.projects.get(id).fetchStories();
        });
      };

      Punches.prototype.refresh = function() {
        var _this = this;
        _(this.views).each(function(view) {
          return view.remove();
        });
        return this.updateViews();
      };

      return Punches;

    })(Backbone.View);
  });

}).call(this);
