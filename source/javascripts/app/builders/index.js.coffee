$ =>
  projectsCollection = new PunchIt.Collections.Projects()
  customersCollection = new PunchIt.Collections.Customers()

  allProjectsView = new PunchIt.Views.AllProjects(customers: customersCollection, projects: projectsCollection)

  projectsCollection.fetch()
  customersCollection.fetch()
