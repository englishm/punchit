(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.Calendar = (function(_super) {

      __extends(Calendar, _super);

      function Calendar() {
        this.mouseup = __bind(this.mouseup, this);

        this.mousedown = __bind(this.mousedown, this);

        this.resizeStopped = __bind(this.resizeStopped, this);

        this.addEditablePunch = __bind(this.addEditablePunch, this);

        this.initialize = __bind(this.initialize, this);
        return Calendar.__super__.constructor.apply(this, arguments);
      }

      Calendar.prototype.initialize = function() {
        $('.app-time').on("mousedown", this.mousedown).on("mouseup", this.mouseup);
        this.$el.attr('unselectable', 'on').css('user-select', 'none').on('selectstart', false);
        this.startTime = null;
        return this.stopTime = null;
      };

      Calendar.prototype.addEditablePunch = function($punchEl, start, stop) {
        var padding, tickHeight, ticks, ticksInHour;
        padding = 2;
        ticksInHour = 4;
        tickHeight = 38;
        ticks = (stop - start) / .25;
        $punchEl.css('top', "" + (padding + ((start * ticksInHour) * tickHeight)) + "px");
        $punchEl.css("height", "" + ((tickHeight * ticks) - 3 * padding) + "px");
        this.$('.app-punches').append($punchEl);
        return $punchEl.resizable({
          autoHide: true,
          grid: [0, tickHeight],
          handles: "s, n",
          start: this.resizeStarted,
          stop: this.resizeStopped
        });
      };

      Calendar.prototype.resizeStopped = function(event, ui) {
        var pulledFromBottom, quarterHourChanges;
        pulledFromBottom = ui.position.top === ui.originalPosition.top;
        if (pulledFromBottom) {
          quarterHourChanges = (ui.element.height() - ui.originalSize.height) / 38;
          return ui.element.trigger('stopChanged', quarterHourChanges * .25);
        } else {
          quarterHourChanges = (ui.originalSize.height - ui.element.height()) / 38;
          return ui.element.trigger('startChanged', quarterHourChanges * .25);
        }
      };

      Calendar.prototype.mousedown = function(event) {
        return this.startTime = parseFloat($(event.currentTarget).data('time'));
      };

      Calendar.prototype.mouseup = function(event) {
        if (!this.startTime) {
          return;
        }
        this.stopTime = parseFloat($(event.currentTarget).data('time'));
        if (this.startTime === this.stopTime) {
          PunchIt.Events.trigger("startStopChanged", this.startTime, this.startTime + .25);
        } else if (this.startTime > this.stopTime) {
          PunchIt.Events.trigger("startStopChanged", this.stopTime, this.startTime + .25);
        } else {
          PunchIt.Events.trigger("startStopChanged", this.startTime, this.stopTime + .25);
        }
        this.startTime = null;
        return this.stopTime = null;
      };

      return Calendar;

    })(Backbone.View);
  });

}).call(this);
