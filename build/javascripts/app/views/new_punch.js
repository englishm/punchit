(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.NewPunch = (function(_super) {

      __extends(NewPunch, _super);

      function NewPunch() {
        this.ready = __bind(this.ready, this);

        this.refresh = __bind(this.refresh, this);

        this.punachableActivated = __bind(this.punachableActivated, this);

        this.timePicked = __bind(this.timePicked, this);

        this.pinProject = __bind(this.pinProject, this);

        this.initialize = __bind(this.initialize, this);
        return NewPunch.__super__.constructor.apply(this, arguments);
      }

      NewPunch.prototype.initialize = function() {
        PunchIt.Events.on("punchableActivated", this.punachableActivated);
        PunchIt.Events.on("startStopChanged", this.timePicked);
        this.datePicker = $('.app-punch-date');
        return this.$('.app-project').on('click', this.pinProject);
      };

      NewPunch.prototype.pinProject = function() {
        if (this.project) {
          return PunchIt.Session.pinProjectId(this.project.id);
        }
      };

      NewPunch.prototype.timePicked = function(start, stop) {
        var punchAttributes;
        if (!this.ready()) {
          return;
        }
        punchAttributes = {
          project_id: this.project.id,
          story_id: this.story ? this.story.id : void 0,
          date: this.datePicker.val(),
          start: start,
          stop: stop
        };
        return this.collection.create(punchAttributes);
      };

      NewPunch.prototype.punachableActivated = function(project, story) {
        this.project = project;
        this.story = story;
        return this.refresh();
      };

      NewPunch.prototype.refresh = function() {
        this.$el.removeClass('alert-success alert-info');
        if (this.ready()) {
          this.$el.addClass('alert-success');
        } else {
          this.$el.addClass('alert-info');
        }
        if (this.project) {
          this.$('.app-project').html("<span class='btn btn-mini'><i class='icon-heart'></i></span> " + (this.project.fullName()));
        } else {
          this.$('.app-project').text('');
        }
        if (this.story) {
          return this.$('.app-story').text(this.story.fullName());
        } else {
          return this.$('.app-story').text('');
        }
      };

      NewPunch.prototype.ready = function() {
        return (this.project && !this.project.hasStories()) || (this.project && this.story);
      };

      return NewPunch;

    })(Backbone.View);
  });

}).call(this);
