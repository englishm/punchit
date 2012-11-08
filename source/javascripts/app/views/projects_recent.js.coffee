namespace "Punch.Views", (exports) ->
  class exports.ProjectsRecent extends Backbone.View
    initialize: ({@projects}) =>
      @collection.on 'reset', @refresh

    refresh: =>
      @$el.html("")
      groupedPunches = @collection.groupBy (punch) =>
        punch.get('project_id')

      _(groupedPunches).each (punches, project_id) =>
        project = @projects.get(project_id)
        @$el.append("<li class='divider'></li>")
        if project.hasStories()
          @$el.append("<li class='nav-header'>#{project.fullName()}</li>")
          _(punches).each (punch) =>
            story_id = punch.get('story_id')
            if story_id
              story = project.getStory(story_id)
              console.log story
              console.log story_id
              console.log project
              if story
                @$el.append("<li>#{story.fullName()}</li>")
        else
          @$el.append("<li>#{project.fullName()}</li>")
   
