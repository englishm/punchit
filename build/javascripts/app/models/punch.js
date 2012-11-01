(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Models", function(exports) {
    return exports.Punch = (function(_super) {

      __extends(Punch, _super);

      function Punch() {
        this.parse = __bind(this.parse, this);

        this.duration = __bind(this.duration, this);

        this.deactivate = __bind(this.deactivate, this);

        this.activate = __bind(this.activate, this);

        this.initialize = __bind(this.initialize, this);
        return Punch.__super__.constructor.apply(this, arguments);
      }

      Punch.prototype.initialize = function() {
        this.project = null;
        return this.active = false;
      };

      Punch.prototype.activate = function() {
        this.active = true;
        this.trigger("change");
        return this.trigger("activate");
      };

      Punch.prototype.deactivate = function() {
        this.active = false;
        this.trigger("change");
        return this.trigger("deactivate");
      };

      Punch.prototype.duration = function() {
        return this.get('stop') - this.get('start');
      };

      Punch.prototype.parse = function(raw) {
        return {
          id: raw['id'],
          date: raw['date'],
          project_id: raw.project.id,
          story_id: raw.story ? raw.story.id : null,
          notes: raw['notes'],
          start: parseFloat(raw['start']),
          stop: parseFloat(raw['stop'])
        };
      };

      return Punch;

    })(Backbone.Model);
  });

}).call(this);
