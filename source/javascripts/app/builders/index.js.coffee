$ =>
  employeesCollection = new PunchIt.Collections.Employees()
  employeesView = new PunchIt.Views.Employees(collection: employeesCollection, el: '#app-employees')
  employeesCollection.fetch()

  projectsCollection = new PunchIt.Collections.Projects()
  customersCollection = new PunchIt.Collections.Customers()

  allProjectsView = new PunchIt.Views.AllProjects(customers: customersCollection, projects: projectsCollection, el: $('#app-all-projects'))
  newPunchView = new PunchIt.Views.NewPunch(el: $('#app-active-story'))

  projectsCollection.fetch()
  customersCollection.fetch()
  
  $('.titled').tooltip()

  punchesCollection = new PunchIt.Collections.Punches()
  punchesView = new PunchIt.Views.Punches(collection: punchesCollection, el: '#app-punches')

  $('.app-punch-date').datepicker()

