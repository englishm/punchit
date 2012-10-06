namespace "PunchIt.Views", (exports) ->
  class exports.AllProjects extends Backbone.View
    initialize: ({@projects, @customers}) =>
      @projects.bind("reset", @refresh)
      @customers.bind("reset", @refresh)

      @$('.app-all-projects-typeahead').bind('change', @projectPicked)

    refresh: =>
      #make sure both collections have loaded
      return unless @projects.length > 0 && @customers.length > 0

      @setCustomers() #TODO this should not be in this class

      #load up the typeahead data
      @$('.app-all-projects-typeahead').data('source', @projects.pluck("fullName"))
      @$('.app-all-projects-typeahead').removeAttr('disabled')
    
    setCustomers: =>
      @projects.each (project) =>
        project.setCustomer(@customers.get(project.get('customerId')))


    projectPicked: (event) =>
      project = @projects.find (project) => project.get('fullName') == @$('.app-all-projects-typeahead').val()
      projectView = new PunchIt.Views.Project(model: project)
      @$('.app-all-project-stories').html(projectView.el)
