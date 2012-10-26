namespace "PunchIt.Views", (exports) ->
  class exports.AllProjects extends Backbone.View
    initialize: ({@projects}) =>
      @$('.app-all-projects-typeahead').on('change', @projectPicked)

    render: =>
      data = []
      @projects.each (project) =>
        data.push(id: project.id, text: project.fullName()) if project.isPunchable()

      @$('.app-all-projects-typeahead').select2 width: "resolve", placeholder: "Search for a project", data: data

    projectPicked: (event) =>
      project = @projects.get $(event.currentTarget).val()
      projectView = new PunchIt.Views.Project(model: project)
      @$('.app-all-project-stories').append(projectView.el)
      @$('.app-all-project-stories').append("<li><br /><br /></li>")
