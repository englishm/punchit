(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Models", function(exports) {
    return exports.Project = (function(_super) {

      __extends(Project, _super);

      function Project() {
        this.parse = __bind(this.parse, this);

        this.isSales = __bind(this.isSales, this);

        this.getStory = __bind(this.getStory, this);

        this.isPunchable = __bind(this.isPunchable, this);

        this.fullName = __bind(this.fullName, this);

        this.hasStories = __bind(this.hasStories, this);

        this.storiesLoaded = __bind(this.storiesLoaded, this);

        this.fetchStories = __bind(this.fetchStories, this);

        this.stories = __bind(this.stories, this);

        this.initialize = __bind(this.initialize, this);
        return Project.__super__.constructor.apply(this, arguments);
      }

      Project.prototype.initialize = function() {
        var _this = this;
        this.customer = this.collection.getCustomer(this.get('customerId'));
        this.stories = new PunchIt.Collections.Stories();
        this.stories.url = "" + PunchIt.Session.baseURL + (this.get('storiesUrl'));
        return this.stories.bind("reset", function() {
          return _this.trigger("storiesLoaded");
        });
      };

      Project.prototype.stories = function() {
        return this.stories;
      };

      Project.prototype.fetchStories = function() {
        if (!this.hasStories) {
          return this.trigger("storiesLoaded");
        } else if (this.stories.length > 0) {
          return this.trigger("storiesLoaded");
        } else {
          return this.stories.fetch();
        }
      };

      Project.prototype.storiesLoaded = function() {
        return this.stories.length > 0;
      };

      Project.prototype.hasStories = function() {
        return this.get('has_stories');
      };

      Project.prototype.fullName = function() {
        return "" + (this.customer.get('name')) + " " + (this.get('name'));
      };

      Project.prototype.isPunchable = function() {
        return this.get('active') && !this.isSales();
      };

      Project.prototype.getStory = function(id) {
        if (id && this.hasStories()) {
          return this.stories.get(id);
        }
      };

      Project.prototype.isSales = function() {
        return this.get('opportunity_identifier') !== null;
      };

      Project.prototype.parse = function(rawResponse) {
        rawResponse["storiesUrl"] = rawResponse['stories'].$ref;
        rawResponse["customerId"] = rawResponse["customer"].id;
        return rawResponse;
      };

      return Project;

    })(Backbone.Model);
  });

}).call(this);
