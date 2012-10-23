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
        punch.setProject(project)
        projects[projectId] = project

      _(projects).each (project) =>
        project.fetchStories()

    parse: (rawResponses) =>
      raw = _(rawResponses).map (response) =>
        response['project_id'] = response.project.id
        response['storyId'] = if response.story then response.story.id else null
        response
