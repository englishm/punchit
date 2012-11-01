(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.DaySummary = (function(_super) {

      __extends(DaySummary, _super);

      function DaySummary() {
        this.render = __bind(this.render, this);

        this.refresh = __bind(this.refresh, this);

        this.initialize = __bind(this.initialize, this);
        return DaySummary.__super__.constructor.apply(this, arguments);
      }

      DaySummary.prototype.initialize = function() {
        this.collection.on("change", this.refresh);
        this.collection.on("reset", this.refresh);
        this.collection.on("remove", this.refresh);
        return this.collection.on("add", this.refresh);
      };

      DaySummary.prototype.refresh = function() {
        this.$('.app-hours-billable').text(this.collection.billable());
        this.$('.app-hours-non-billable').text(this.collection.nonbillable());
        return this.$('.app-hours-total').text(this.collection.billable() + this.collection.nonbillable());
      };

      DaySummary.prototype.render = function() {
        return this.refresh();
      };

      return DaySummary;

    })(Backbone.View);
  });

}).call(this);
