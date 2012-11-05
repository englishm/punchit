namespace "Punch.Views", (exports) ->
  class exports.AllProjects extends Backbone.View
    initialize: ({@projects}) =>
      @$('.app-all-projects-typeahead').on('change', @projectPicked)

    render: =>
      data = []
      @projects.each (project) =>
        data.push(id: project.id, text: project.fullName()) if project.isPunchable()

      @$('.app-all-projects-typeahead').select2
        width: "100%"
        placeholder: "Search for a project"
        data: data
        allowClear: true

    projectPicked: (event) =>
      project = @projects.get $(event.currentTarget).val()
      @$('.app-all-projects-typeahead').val()

      Punch.Events.trigger "punchableActivated", project

      projectView = new Punch.Views.Project(model: project)
      @$('.app-stories-placeholder').append("<li class='divider'></li>")
      @$('.app-stories-placeholder').append("<li class='nav-header'>#{project.fullName()} Stories</li>") if project.hasStories()
      @$('.app-stories-placeholder').append(projectView.el)

