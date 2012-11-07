namespace "Punch.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: =>
      Punch.Events.on "punchableActivated", @punachableActivated
      Punch.Events.on "startStopChanged", @timePicked

      @.$('.app-project').on 'click', @pinProject

    pinProject: =>
      if @project
        Punch.Session.pinProjectId @project.id
      
    timePicked: (start, stop) =>
      return unless @ready()
      punchAttributes =
        project_id: @project.id
        story_id: @story.id if @story
        date: Punch.Session.getDateAsString()
        start: start
        stop: stop

      @collection.create(punchAttributes)

    punachableActivated: (project, story) =>
      @project = project
      @story = story
      @refresh()

    refresh: =>
      @$el.removeClass('btn-success')

      @.$('.app-project').text('')
      @.$('.app-story').text('')

      if @ready()
        @$el.addClass('btn-success')
        @$('.app-project').text(@project.fullName())
        if @story
          @.$('.app-story').text(@story.fullName())
        else
          @.$('.app-story').text('')
      else if @project
        @$('.app-project').text(@project.fullName())

    ready: =>
      (@project and !@project.hasStories()) or  (@project and @story)

    # createDefault: =>

    #   punch = new Punch.Models.Punch(attributes)
    #   if arguments and arguments[0] and arguments[0].setDefaults
    #     lastpunch = @punchescollection.max (punch) =>
    #       punch.get('stop')

    #     if lastPunch
    #       nextPunchStart = lastPunch.get('stop')
    #     else
    #       nextPunchStart = 8

    #     punch.setStart(nextPunchStart)

    #   @punchesCollection.add(punch)
    #   @punchActivated(punch)

    #   #TODO: work with Karlin on OS detection 
    #   $(document).on "keypress", (event) =>
    #     if event.keyCode == 27
    #       @deactivateModel()
    #     else if event.keyCode == 8 and event.altKey
    #       @destroyModel()
    #       return false
    #     # else if event.which == 13
    #     # Not sure what to do with enter
    #     #   Punch.Events.trigger "savePunch"

    #   #this should be moved to a DAY view that doesn't exist or punches?
    #   $('.app-time').on 'click', (event) =>
    #     if event.altKey
    #       Punch.Events.trigger "startTime", $(event.currentTarget).data('time')
    #     else
    #       Punch.Events.trigger "stopTime", $(event.currentTarget).data('time')
