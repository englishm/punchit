$ =>
  #date finder
  $('.app-punch-date').datepicker(format: 'yyyy-mm-dd')

  #bootstrap tooltips
  $('.titled').tooltip()

  employeesCollection = new PunchIt.Collections.Employees()
  employeesView = new PunchIt.Views.Employees(collection: employeesCollection, el: '.app-employee')
  employeesCollection.fetch()

  customersCollection = new PunchIt.Collections.Customers()
  projectsCollection = new PunchIt.Collections.Projects(customers: customersCollection)

  allProjectsView = new PunchIt.Views.AllProjects(projects: projectsCollection, el: $('#app-all-projects'))
  newPunchView = new PunchIt.Views.NewPunch(el: $('#app-active-story'))

  punchesCollection = new PunchIt.Collections.Punches()
  punchesView = new PunchIt.Views.Punches(collection: punchesCollection, el: '#app-punches')


