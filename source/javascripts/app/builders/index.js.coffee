$ =>
  projectsCollection = new PunchIt.Collections.Projects()
  customersCollection = new PunchIt.Collections.Customers()

  allProjectsView = new PunchIt.Views.AllProjects(customers: customersCollection, projects: projectsCollection, el: $('#app-all-projects'))
  newPunchView = new PunchIt.Views.NewPunch(el: $('#app-active-story'))

  projectsCollection.fetch()
  customersCollection.fetch()
  
  $('.titled').tooltip()
