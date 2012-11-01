(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.Project = (function(_super) {

      __extends(Project, _super);

      function Project() {
        this.populateStories = __bind(this.populateStories, this);

        this.projectClicked = __bind(this.projectClicked, this);

        this.storyPicked = __bind(this.storyPicked, this);

        this.initialize = __bind(this.initialize, this);
        return Project.__super__.constructor.apply(this, arguments);
      }

      Project.prototype.tagName = "li";

      Project.prototype.className = "project";

      Project.prototype.events = {
        "click app-pick": "projectClicked"
      };

      Project.prototype.initialize = function() {
        var _this = this;
        if (this.model.hasStories()) {
          $(this.el).html('<input class="app-stories input-xxlarge" type="hidden" />');
          this.model.on("storiesLoaded", this.populateStories);
          this.model.fetchStories();
          return this.$('.app-stories').on("change", this.storyPicked);
        } else {
          $(this.el).html("<a href='#" + this.model.id + "'>" + (this.model.fullName()) + "</a>");
          return $(this.el).on('click', function() {
            return _this.projectClicked();
          });
        }
      };

      Project.prototype.storyPicked = function(event) {
        return PunchIt.Events.trigger("punchableActivated", this.model, this.model.stories.get($(event.currentTarget).val()));
      };

      Project.prototype.projectClicked = function() {
        return PunchIt.Events.trigger("punchableActivated", this.model, null);
      };

      Project.prototype.populateStories = function() {
        var $storiesTypeahead, data,
          _this = this;
        data = [];
        this.model.stories.each(function(story) {
          if (!story.completed()) {
            return data.push({
              id: story.id,
              text: story.get('name')
            });
          }
        });
        return $storiesTypeahead = this.$('.app-stories').select2({
          width: "100%",
          placeholder: "Search for a story for " + (this.model.fullName()),
          data: data
        });
      };

      return Project;

    })(Backbone.View);
  });

}).call(this);
