(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Projects = (function(_super) {

      __extends(Projects, _super);

      function Projects() {
        this.getCustomer = __bind(this.getCustomer, this);

        this.loadUp = __bind(this.loadUp, this);

        this.initialize = __bind(this.initialize, this);
        return Projects.__super__.constructor.apply(this, arguments);
      }

      Projects.prototype.model = PunchIt.Models.Project;

      Projects.prototype.url = "" + PunchIt.Session.baseURL + "/projects";

      Projects.prototype.initialize = function(_arg) {
        this.customers = _arg.customers;
        this.customers.on("reset", this.loadUp);
        return this.customers.fetch();
      };

      Projects.prototype.loadUp = function() {
        return this.fetch();
      };

      Projects.prototype.getCustomer = function(id) {
        return this.customers.get(id);
      };

      return Projects;

    })(Backbone.Collection);
  });

}).call(this);
