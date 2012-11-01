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
