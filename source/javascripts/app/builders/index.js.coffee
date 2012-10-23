$ =>
  #date finder
  # $('.app-punch-date').datepicker('show', format: 'yyyy-mm-dd')
  $('.app-punch-date').datepicker('show')

  #bootstrap tooltips
  $('.titled').tooltip()

  customersCollection = new PunchIt.Collections.Customers()
  projectsCollection = new PunchIt.Collections.Projects(customers: customersCollection)

  projectsCollection.on "reset", =>
    employeesCollection = new PunchIt.Collections.Employees()
    employeesView = new PunchIt.Views.Employees(collection: employeesCollection, el: '.app-employee')
    employeesCollection.fetch()


    allProjectsView = new PunchIt.Views.AllProjects(projects: projectsCollection, el: $('#app-all-projects'))
    allProjectsView.render()


    punchesCollection = new PunchIt.Collections.Punches([], projects: projectsCollection)
    punchesView = new PunchIt.Views.Punches(projects: projectsCollection, collection: punchesCollection, el: '#app-punches')

    newPunchView = new PunchIt.Views.NewPunch(el: $('#app-active-story'), collection: punchesCollection)
