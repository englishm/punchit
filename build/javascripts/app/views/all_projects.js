(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.AllProjects = (function(_super) {

      __extends(AllProjects, _super);

      function AllProjects() {
        this.projectPicked = __bind(this.projectPicked, this);

        this.render = __bind(this.render, this);

        this.initialize = __bind(this.initialize, this);
        return AllProjects.__super__.constructor.apply(this, arguments);
      }

      AllProjects.prototype.initialize = function(_arg) {
        this.projects = _arg.projects;
        return this.$('.app-all-projects-typeahead').on('change', this.projectPicked);
      };

      AllProjects.prototype.render = function() {
        var data,
          _this = this;
        data = [];
        this.projects.each(function(project) {
          if (project.isPunchable()) {
            return data.push({
              id: project.id,
              text: project.fullName()
            });
          }
        });
        return this.$('.app-all-projects-typeahead').select2({
          width: "100%",
          placeholder: "Search for a project",
          data: data
        });
      };

      AllProjects.prototype.projectPicked = function(event) {
        var project, projectView;
        project = this.projects.get($(event.currentTarget).val());
        PunchIt.Events.trigger("punchableActivated", project);
        projectView = new PunchIt.Views.Project({
          model: project
        });
        return this.$('.app-stories-placeholder').append(projectView.el);
      };

      return AllProjects;

    })(Backbone.View);
  });

}).call(this);
