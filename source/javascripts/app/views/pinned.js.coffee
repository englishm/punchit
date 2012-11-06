namespace "Punch.Views", (exports) ->
  class exports.Pinned extends Backbone.View
    initialize: ({@projectsCollection}) =>
      # Punch.Events.on "punchableActivated", @punachableActivated
      # Punch.Events.on "startStopChanged", @timePicked

      # @.$('.app-project').on 'click', @pinProject
      
    render: =>
      _($.jStorage.get('pinnedProjectIds')).each (id) =>
        project = @projectsCollection.get id
        projectView = new Punch.Views.Project(model: project)
        if project.hasStories()
          @$('.app-projects').append("<li class='divider'></li>")
          @$('.app-projects').append("<li class='nav-header'>#{project.fullName()} Stories</li>") if project.hasStories()
          @.$('.app-projects').append(projectView.el)
        else
          @.$('.app-punchables').append(projectView.el)
