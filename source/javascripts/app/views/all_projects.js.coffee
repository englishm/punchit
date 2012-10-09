namespace "PunchIt.Views", (exports) ->
  class exports.AllProjects extends Backbone.View
    initialize: ({@projects, @customers}) =>
      @projects.bind("reset", @refresh)
      @customers.bind("reset", @refresh)

      @$('.app-all-projects-typeahead').bind('change', @projectPicked)

    refresh: =>
      #make sure both collections have loaded
      return unless @projects.length > 0 && @customers.length > 0

      #TODO this should not be in this class
      @setCustomers() 

      #load up the typeahead data
      data = []
      @projects.each (project) =>
        data.push(id: project.id, text: project.get('fullName')) if project.get('active')

      @$('.app-all-projects-typeahead').select2 placeholder: "Search for a project", data: data

    setCustomers: =>
      @projects.each (project) =>
        project.setCustomer(@customers.get(project.get('customerId')))


    projectPicked: (event) =>
      project = @projects.get $(event.currentTarget).val()
      projectView = new PunchIt.Views.Project(model: project)
      @$('.app-all-project-stories').append(projectView.el)
