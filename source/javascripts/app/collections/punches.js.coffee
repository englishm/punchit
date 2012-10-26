namespace "PunchIt.Collections", (exports) ->
  class exports.Punches extends Backbone.Collection
    model: PunchIt.Models.Punch
    url: "/punches"

    initialize: =>
      @projects =  arguments[1].projects

    loadPunches: =>
      @fetch(success: @loadStories)

    loadStories: =>
      projects = {}

      @each (punch) =>
        projectId = punch.get('project_id')
        project = @projects.get(projectId)
        projects[projectId] = project

      _(projects).each (project) =>
        project.fetchStories()
