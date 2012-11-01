(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt", function(exports) {
    return exports.Events = (function(_super) {

      __extends(Events, _super);

      function Events() {
        return Events.__super__.constructor.apply(this, arguments);
      }

      return Events;

    })(Backbone.Events);
  });

}).call(this);
(function() {

  namespace("PunchIt.Session", function(exports) {
    var _this = this;
    exports.getEmployeeId = function() {
      return $.jStorage.get('employeeId');
    };
    exports.setEmployeeId = function(id) {
      $.jStorage.set('employeeId', id);
      return PunchIt.Events.trigger('changed:employeeId', id);
    };
    PunchIt.Session.baseURL = "https://punchitapi.atomicobject.com";
    exports.onAuthenticated = function(callback) {
      if (!exports.baseURL) {
        throw "PunchIt.Session.BaseURL is NOT set";
      }
      if (exports.baseURL === "http://localhost:4568") {
        return callback();
      } else {
        $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
          return options.xhrFields = {
            withCredentials: true
          };
        });
        return $("<img id='punchitapi-blank-img' src='" + exports.baseURL + "/blank.png?" + Number(new Date()) + "'/>").load(callback).error(function() {
          return log("You are not authenticated @ punchitapi.atomicobject.com");
        }).appendTo($('body'));
      }
    };
    exports.bootstrap = function() {
      var dustinsId, general, holiday, lunch, vacation;
      if (!$.jStorage.get('pinnedProjectIds')) {
        general = 1;
        lunch = 30;
        vacation = 18;
        holiday = 17;
        $.jStorage.set('pinnedProjectIds', [general, lunch, vacation, holiday]);
      }
      if (!$.jStorage.get('employeeId')) {
        dustinsId = 31;
        return $.jStorage.set('employeeId', dustinsId);
      }
    };
    return exports.pinProjectId = function(id) {
      var projects;
      projects = $.jStorage.get('pinnedProjectIds');
      if (_.indexOf(projects, id) < 0) {
        projects.push(id);
        return $.jStorage.set('pinnedProjectIds', projects);
      }
    };
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Models", function(exports) {
    return exports.Customer = (function(_super) {

      __extends(Customer, _super);

      function Customer() {
        return Customer.__super__.constructor.apply(this, arguments);
      }

      return Customer;

    })(Backbone.Model);
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Models", function(exports) {
    return exports.Employee = (function(_super) {

      __extends(Employee, _super);

      function Employee() {
        return Employee.__super__.constructor.apply(this, arguments);
      }

      return Employee;

    })(Backbone.Model);
  });

}).call(this);
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
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Customers = (function(_super) {

      __extends(Customers, _super);

      function Customers() {
        return Customers.__super__.constructor.apply(this, arguments);
      }

      Customers.prototype.model = PunchIt.Models.Customer;

      Customers.prototype.url = "" + PunchIt.Session.baseURL + "/customers";

      return Customers;

    })(Backbone.Collection);
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Employees = (function(_super) {

      __extends(Employees, _super);

      function Employees() {
        return Employees.__super__.constructor.apply(this, arguments);
      }

      Employees.prototype.model = PunchIt.Models.Employee;

      Employees.prototype.url = "" + PunchIt.Session.baseURL + "/employees?active=true";

      return Employees;

    })(Backbone.Collection);
  });

}).call(this);
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
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Punches = (function(_super) {

      __extends(Punches, _super);

      function Punches() {
        this.nextStartTime = __bind(this.nextStartTime, this);

        this.nonbillable = __bind(this.nonbillable, this);

        this.billable = __bind(this.billable, this);

        this.activePunch = __bind(this.activePunch, this);

        this.loadStories = __bind(this.loadStories, this);

        this.loadPunches = __bind(this.loadPunches, this);

        this.initialize = __bind(this.initialize, this);
        return Punches.__super__.constructor.apply(this, arguments);
      }

      Punches.prototype.model = PunchIt.Models.Punch;

      Punches.prototype.url = "" + PunchIt.Session.baseURL + "/punches";

      Punches.prototype.initialize = function() {
        return this.projects = arguments[1].projects;
      };

      Punches.prototype.loadPunches = function() {
        return this.fetch({
          success: this.loadStories
        });
      };

      Punches.prototype.loadStories = function() {
        var projects,
          _this = this;
        projects = {};
        this.each(function(punch) {
          var project, projectId;
          projectId = punch.get('project_id');
          project = _this.projects.get(projectId);
          return projects[projectId] = project;
        });
        return _(projects).each(function(project) {
          return project.fetchStories();
        });
      };

      Punches.prototype.activePunch = function() {
        var _this = this;
        return this.find(function(punch) {
          return punch.active;
        });
      };

      Punches.prototype.billable = function() {
        var billableTotal,
          _this = this;
        billableTotal = 0;
        this.each(function(punch) {
          var project;
          project = _this.projects.get(punch.get('project_id'));
          if (project && project.get('billable')) {
            return billableTotal = billableTotal + punch.duration();
          }
        });
        return billableTotal;
      };

      Punches.prototype.nonbillable = function() {
        var nonBillableTotal,
          _this = this;
        nonBillableTotal = 0;
        this.each(function(punch) {
          var project;
          project = _this.projects.get(punch.get('project_id'));
          if (project && !project.get('billable') && !project.get('personal')) {
            return nonBillableTotal = nonBillableTotal + punch.duration();
          }
        });
        return nonBillableTotal;
      };

      Punches.prototype.nextStartTime = function(date) {
        var lastPunch,
          _this = this;
        lastPunch = this.max(function(punch) {
          return punch.get('stop');
        });
        if (lastPunch) {
          return lastPunch.get('stop');
        } else {
          return 9;
        }
      };

      return Punches;

    })(Backbone.Collection);
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Collections", function(exports) {
    return exports.Stories = (function(_super) {

      __extends(Stories, _super);

      function Stories() {
        return Stories.__super__.constructor.apply(this, arguments);
      }

      Stories.prototype.model = PunchIt.Models.Story;

      return Stories;

    })(Backbone.Collection);
  });

}).call(this);
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
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.Employee = (function(_super) {

      __extends(Employee, _super);

      function Employee() {
        this.render = __bind(this.render, this);

        this.refresh = __bind(this.refresh, this);

        this.updateEmployee = __bind(this.updateEmployee, this);

        this.initialize = __bind(this.initialize, this);
        return Employee.__super__.constructor.apply(this, arguments);
      }

      Employee.prototype.initialize = function() {
        return PunchIt.Events.on("employeePicked", this.updateEmployee);
      };

      Employee.prototype.updateEmployee = function(employee) {
        this.model = employee;
        PunchIt.Session.setEmployeeId(employee.id);
        return this.refresh();
      };

      Employee.prototype.refresh = function() {
        return this.$('.app-name').html(this.model.get('name'));
      };

      Employee.prototype.render = function() {
        return this.refresh();
      };

      return Employee;

    })(Backbone.View);
  });

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.EmployeesModal = (function(_super) {

      __extends(EmployeesModal, _super);

      function EmployeesModal() {
        this.render = __bind(this.render, this);

        this.triggerTypeAhead = __bind(this.triggerTypeAhead, this);

        this.initialize = __bind(this.initialize, this);
        return EmployeesModal.__super__.constructor.apply(this, arguments);
      }

      EmployeesModal.prototype.initialize = function() {
        return $('.app-all-employees-typeahead').on("change", this.triggerTypeAhead);
      };

      EmployeesModal.prototype.triggerTypeAhead = function() {
        var $typeAhead;
        $typeAhead = $('input.app-all-employees-typeahead');
        return PunchIt.Events.trigger("employeePicked", this.collection.get($typeAhead.val()));
      };

      EmployeesModal.prototype.render = function() {
        var data,
          _this = this;
        data = [];
        this.collection.each(function(employee) {
          return data.push({
            id: employee.id,
            text: employee.get('name')
          });
        });
        return $('.app-all-employees-typeahead').select2({
          width: "100%",
          placeholder: "Pick yourself",
          data: data
        });
      };

      return EmployeesModal;

    })(Backbone.View);
  });

}).call(this);
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
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.Punches = (function(_super) {

      __extends(Punches, _super);

      function Punches() {
        this.refresh = __bind(this.refresh, this);

        this.updateViews = __bind(this.updateViews, this);

        this.addModel = __bind(this.addModel, this);

        this.employeeId = __bind(this.employeeId, this);

        this.updatePunches = __bind(this.updatePunches, this);

        this.initialize = __bind(this.initialize, this);
        return Punches.__super__.constructor.apply(this, arguments);
      }

      Punches.prototype.initialize = function(_arg) {
        this.projects = _arg.projects, this.calendarView = _arg.calendarView;
        this.collection.url = "/employees/" + (this.employeeId()) + "/punches";
        this.datePicker = $('.app-punch-date');
        this.datePicker.on('changeDate', this.updatePunches);
        PunchIt.Events.on("changed:employeeId", this.updatePunches);
        this.collection.on('reset', this.refresh);
        this.collection.on('add', this.updateViews);
        this.views = {};
        return this.updatePunches();
      };

      Punches.prototype.updatePunches = function() {
        this.collection.url = "" + PunchIt.Session.baseURL + "/employees/" + (this.employeeId()) + "/punches?date.gte=" + (this.datePicker.val()) + "&date.lte=" + (this.datePicker.val());
        this.collection.loadPunches();
        return this.collection.url = "" + PunchIt.Session.baseURL + "/employees/" + (this.employeeId()) + "/punches";
      };

      Punches.prototype.employeeId = function() {
        return PunchIt.Session.getEmployeeId();
      };

      Punches.prototype.addModel = function(model) {
        return this.collection.add(model);
      };

      Punches.prototype.updateViews = function() {
        var _this = this;
        this.collection.each(function(punch) {
          var start, stop;
          if (!_this.views[punch.cid]) {
            _this.views[punch.cid] = new PunchIt.Views.Punch({
              model: punch,
              projects: _this.projects
            });
            _this.views[punch.cid].render();
            start = punch.get('start');
            stop = punch.get('stop');
            return _this.calendarView.addEditablePunch($(_this.views[punch.cid].el), start, stop);
          }
        });
        return _(this.collection.pluck('project_id')).uniq(function(id) {
          return _this.projects.get(id).fetchStories();
        });
      };

      Punches.prototype.refresh = function() {
        var _this = this;
        _(this.views).each(function(view) {
          return view.remove();
        });
        return this.updateViews();
      };

      return Punches;

    })(Backbone.View);
  });

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  namespace("PunchIt.Views", function(exports) {
    return exports.WeekSummary = (function(_super) {

      __extends(WeekSummary, _super);

      function WeekSummary() {
        this.employeeId = __bind(this.employeeId, this);

        this.render = __bind(this.render, this);

        this.refresh = __bind(this.refresh, this);

        this.initialize = __bind(this.initialize, this);
        return WeekSummary.__super__.constructor.apply(this, arguments);
      }

      WeekSummary.prototype.initialize = function() {
        var saturday, sunday;
        this.collection.on("change", this.refresh);
        this.collection.on("reset", this.refresh);
        this.collection.on("remove", this.refresh);
        this.collection.on("add", this.refresh);
        sunday = '2012-10-28';
        saturday = '2012-11-03';
        this.collection.url = "/employees/" + (this.employeeId()) + "/punches?date.gte=" + sunday + "&date.lte=" + saturday;
        return this.collection.loadPunches();
      };

      WeekSummary.prototype.refresh = function() {
        var billable, nonbillable;
        billable = this.collection.billable();
        nonbillable = this.collection.nonbillable();
        this.$('.progress .app-hours-billable').width("" + (billable * 2) + "%");
        this.$('.progress .app-hours-non-billable').width("" + (nonbillable * 2) + "%");
        this.$('.badge.app-hours-billable').text(billable);
        return this.$('.badge.app-hours-non-billable').text(nonbillable);
      };

      WeekSummary.prototype.render = function() {
        return this.refresh();
      };

      WeekSummary.prototype.employeeId = function() {
        return PunchIt.Session.getEmployeeId();
      };

      return WeekSummary;

    })(Backbone.View);
  });

}).call(this);
(function() {
  var _this = this;

  PunchIt.Session.baseURL = "https://punchitapi.atomicobject.com";

  PunchIt.Session.onAuthenticated(function() {
    var customersCollection, employeesCollection, projectsCollection;
    window.scrollTo(0, 1000);
    PunchIt.Session.bootstrap();
    $('.app-punch-date').datepicker('show');
    $('.titled').tooltip();
    customersCollection = new PunchIt.Collections.Customers();
    employeesCollection = new PunchIt.Collections.Employees();
    projectsCollection = new PunchIt.Collections.Projects({
      customers: customersCollection
    });
    projectsCollection.on("reset", function() {
      return employeesCollection.fetch();
    });
    return employeesCollection.on("reset", function() {
      var activeEmployee, activeEmployeeView, allProjectsView, caldendarView, daySummary, employeesView, newPunchView, punchesCollection, punchesView;
      employeesView = new PunchIt.Views.EmployeesModal({
        collection: employeesCollection,
        el: '#app-employees-modal'
      });
      employeesView.render();
      activeEmployee = employeesCollection.get(PunchIt.Session.getEmployeeId());
      activeEmployeeView = new PunchIt.Views.Employee({
        model: activeEmployee,
        el: '.app-employee'
      });
      activeEmployeeView.render();
      allProjectsView = new PunchIt.Views.AllProjects({
        projects: projectsCollection,
        el: $('#app-all-projects')
      });
      allProjectsView.render();
      caldendarView = new PunchIt.Views.Calendar({
        el: '#app-calendar'
      });
      punchesCollection = new PunchIt.Collections.Punches([], {
        projects: projectsCollection
      });
      punchesView = new PunchIt.Views.Punches({
        projects: projectsCollection,
        calendarView: caldendarView,
        collection: punchesCollection
      });
      daySummary = new PunchIt.Views.DaySummary({
        collection: punchesCollection,
        el: $('#app-day-summary')
      });
      newPunchView = new PunchIt.Views.NewPunch({
        el: $('#app-new-punch'),
        collection: punchesCollection
      });
      return _($.jStorage.get('pinnedProjectIds')).each(function(id) {
        var project, projectView;
        project = projectsCollection.get(id);
        projectView = new PunchIt.Views.Project({
          model: project
        });
        return _this.$('#app-pinned-projects').append(projectView.el);
      });
    });
  });

}).call(this);





