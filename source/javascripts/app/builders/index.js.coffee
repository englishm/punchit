$ =>
  #TODO this should be based on 8am or current time
  # 5 per hour that it is
  # 
  window.scrollTo(0,1000)
  PunchIt.Session.bootstrap()

  #date finder
  # $('.app-punch-date').datepicker('show', format: 'yyyy-mm-dd')
  $('.app-punch-date').datepicker('show')
  #bootstrap tooltips
  $('.titled').tooltip()

  customersCollection = new PunchIt.Collections.Customers()
  employeesCollection = new PunchIt.Collections.Employees()
  projectsCollection  = new PunchIt.Collections.Projects(customers: customersCollection)

  projectsCollection.on "reset", =>
    employeesCollection.fetch()

  employeesCollection.on "reset", =>
    employeesView = new PunchIt.Views.EmployeesModal(collection: employeesCollection, el: '#app-employees-modal')
    employeesView.render()

    activeEmployee = employeesCollection.get(PunchIt.Session.getEmployeeId())
    activeEmployeeView = new PunchIt.Views.Employee(model: activeEmployee, el: '.app-employee')
    activeEmployeeView.render()

    allProjectsView = new PunchIt.Views.AllProjects(projects: projectsCollection, el: $('#app-all-projects'))
    allProjectsView.render()


    punchesCollection = new PunchIt.Collections.Punches([], projects: projectsCollection)
    punchesView = new PunchIt.Views.Punches(projects: projectsCollection, collection: punchesCollection, el: '#app-punches')

    daySummary = new PunchIt.Views.DaySummary(collection: punchesCollection, el: $('#app-day-summary'))

    punchesWeekCollection = new PunchIt.Collections.Punches([], projects: projectsCollection)
    weekSummary = new PunchIt.Views.WeekSummary(collection: punchesWeekCollection, el: $('#app-week-summary'))

    newPunchView = new PunchIt.Views.NewPunch(punchesCollection: punchesCollection, punchesView: punchesView, datePicker: $('.app-punch-date'))

    _($.jStorage.get('pinnedProjectIds')).each (id) =>
      project = projectsCollection.get id
      projectView = new PunchIt.Views.Project(model: project)
      @$('#app-pinned-projects').after(projectView.el)

