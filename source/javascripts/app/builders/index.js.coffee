$ =>
  projectsCollection = new PunchIt.Collections.Projects()
  projectsView = new PunchIt.Views.Projects(collection: projectsCollection)
  projectsCollection.fetch()
