$ =>
  Punch.Session.onAuthenticated =>
    #TODO this should be based on 8am or current time
    # 5 per hour that it is
    window.scrollTo(0,1000)

    Punch.Session.bootstrap()

    #date finder where should this go?
    #$('.app-punch-date').datepicker()
    $('.app-punch-date').datepicker('show')
    $('.app-today').on 'click', =>
      d = new Date
      $('.app-punch-date').datepicker('setValue', Date.today())
      $('.app-punch-date').trigger('changeDate')
    #bootstrap tooltips
    $('.titled').tooltip()

    customersCollection = new Punch.Collections.Customers()
    employeesCollection = new Punch.Collections.Employees()
    projectsCollection  = new Punch.Collections.Projects(customers: customersCollection)

    projectsCollection.on "reset", =>
      employeesCollection.fetch()

    employeesCollection.on "reset", =>
      employeesView = new Punch.Views.EmployeesModal
        collection: employeesCollection
        el: '#app-employees-modal'

      employeesView.render()

      activeEmployee = employeesCollection.get(Punch.Session.getEmployeeId())
      activeEmployeeView = new Punch.Views.Employee
        model: activeEmployee
        el: '.app-employee'
      activeEmployeeView.render()


      allProjectsView = new Punch.Views.AllProjects
        projects: projectsCollection
        el: $('#app-all-projects')
      allProjectsView.render()

      projectsRecentView = new Punch.Views.ProjectsRecent
        collection: punchesCollection
        projects: projectsCollection
        el: $('#app-recent-projects')

      projectsRecentView.render()

      caldendarView = new Punch.Views.Calendar(el: '#app-calendar')
      punchesCollection = new Punch.Collections.Punches([], projects: projectsCollection)

      daySummary = new Punch.Views.DaySummary(collection: punchesCollection, el: $('#app-day-summary'))
      weekSummary = new Punch.Views.WeekSummary(collection: punchesCollection, el: $('#app-week-summary'))
      weekSummary.render()

      punchesView = new Punch.Views.Punches
        collection: punchesCollection
        projects: projectsCollection
        calendarView: caldendarView

      newPunchView = new Punch.Views.NewPunch(el: $('#app-new-punch'), collection: punchesCollection)


      #TODO: Move this to a pinned projects View/Collection that accpets new pins/removes pins
      _($.jStorage.get('pinnedProjectIds')).each (id) =>
        project = projectsCollection.get id
        projectView = new Punch.Views.Project(model: project)
        @$('#app-pinned-projects').append(projectView.el)
