(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Models", function(exports) {
    return exports.Story = (function(_super) {

      __extends(Story, _super);

      function Story() {
        this.fullName = __bind(this.fullName, this);

        this.project_id = __bind(this.project_id, this);

        this.completed = __bind(this.completed, this);
        return Story.__super__.constructor.apply(this, arguments);
      }

      Story.prototype.completed = function() {
        return this.get('percent_done') === 100;
      };

      Story.prototype.project_id = function() {
        return this.get('project').id;
      };

      Story.prototype.fullName = function() {
        return this.get('name');
      };

      return Story;

    })(Backbone.Model);
  });

}).call(this);
