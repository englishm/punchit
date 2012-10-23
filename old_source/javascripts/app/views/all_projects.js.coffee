namespace "PunchIt.Views", (exports) ->
  class exports.AllProjects extends Backbone.View
    initialize: ({@projects}) =>
      @projects.on("reset", @refresh)
      @$('.app-all-projects-typeahead').on('change', @projectPicked)

    refresh: =>
      #load up the typeahead data
      data = []
      @projects.each (project) =>
        data.push(id: project.id, text: project.fullName()) if project.isPunchable()

      @$('.app-all-projects-typeahead').select2 width: "resolve", placeholder: "Search for a project", data: data

    projectPicked: (event) =>
      project = @projects.get $(event.currentTarget).val()
      PunchIt.Events.trigger "projectActivated", project
      projectView = new PunchIt.Views.Project(model: project)
      @$('.app-all-project-stories').append(projectView.el)
