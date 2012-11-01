(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.Punch = (function(_super) {

      __extends(Punch, _super);

      function Punch() {
        this.render = __bind(this.render, this);

        this.refresh = __bind(this.refresh, this);

        this.story = __bind(this.story, this);

        this.project = __bind(this.project, this);

        this.type = __bind(this.type, this);

        this.save = __bind(this.save, this);

        this.initialize = __bind(this.initialize, this);
        return Punch.__super__.constructor.apply(this, arguments);
      }

      Punch.prototype.tagName = "span";

      Punch.prototype.className = "label punch app-punch";

      Punch.prototype.initialize = function(_arg) {
        var _this = this;
        this.projects = _arg.projects;
        this.model.on("change", function() {
          return _this.refresh();
        });
        this.model.on("destroy", function() {
          return _this.remove();
        });
        if (this.project()) {
          this.project().on('storiesLoaded', function() {
            return _this.refresh();
          });
        }
        this.$el.on('stopChanged', function(event, time) {
          var newStop;
          newStop = _this.model.get('stop') + time;
          _this.model.set({
            stop: newStop
          });
          return _this.save();
        });
        return this.$el.on('startChanged', function(event, time) {
          var newstart;
          newstart = _this.model.get('start') + time;
          _this.model.set({
            start: newstart
          });
          return _this.save();
        });
      };

      Punch.prototype.save = function() {
        return this.model.save();
      };

      Punch.prototype.type = function() {
        if (this.model.isNew()) {
          return "default";
        } else if (this.project().get('billable')) {
          return "success";
        } else if (this.project().get('personal')) {
          return "info";
        } else {
          return "warning";
        }
      };

      Punch.prototype.project = function() {
        return this.projects.get(this.model.get('project_id'));
      };

      Punch.prototype.story = function() {
        if (this.project()) {
          return this.project().getStory(this.model.get('story_id'));
        }
      };

      Punch.prototype.refresh = function() {
        this.$el.removeClass("active label-default label-success label-info label-warning");
        this.$el.addClass("label-" + (this.type()));
        if (this.model.active) {
          this.$el.addClass("active");
        }
        this.$('.app-notes').val(this.model.get('notes'));
        if (this.project()) {
          this.$('.app-project').text(this.project().fullName());
        } else {
          this.$('.app-project').text("Pick a project");
        }
        if (this.story()) {
          return this.$('.app-story').text(this.story().fullName());
        } else {
          return this.$('.app-story').text('');
        }
      };

      Punch.prototype.render = function() {
        var _this = this;
        this.$el.attr('rel', 'tooltip');
        this.$el.html("<p>          <span class='punch-controls pull-right'>            <i class='app-remove icon-remove icon-white'></i>          </span>          <span class='app-info'>            <span class='app-project'></span>            <span class='app-story'></span>          </span>        </p>        <input type='text' class='app-notes notes input-xxlarge' placeholder='No Notes' />");
        this.$('.app-info').on('click', function() {
          return PunchIt.Events.trigger("punchableActivated", _this.project(), _this.story());
        });
        this.$('.app-remove').on('click', function() {
          return _this.model.destroy();
        });
        return this.$('.app-notes').on('blur', function() {
          _this.model.set({
            notes: _this.$('.app-notes').val()
          });
          return _this.save();
        });
      };

      return Punch;

    })(Backbone.View);
  });

}).call(this);
