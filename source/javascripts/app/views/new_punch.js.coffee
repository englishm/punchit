namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: =>
      PunchIt.Events.on "punchableActivated", @punachableActivated
      PunchIt.Events.on "startStopChanged", @timePicked

      @datePicker = $('.app-punch-date')
      @.$('.app-project').on 'click', @pinProject

    pinProject: =>
      if @project
        PunchIt.Session.pinProjectId @project.id
      
    timePicked: (start, stop) =>
      return unless @ready()
      punchAttributes =
        project_id: @project.id
        story_id: @story.id if @story
        date: @datePicker.val()
        start: start
        stop: stop

      @collection.create(punchAttributes)

    punachableActivated: (project, story) =>
      @project = project
      @story = story
      @refresh()

    refresh: =>
      @$el.removeClass('alert-success')
      if @ready()
        @$el.addClass('alert-success')
        @$('.app-project').html("
          <span class='controls pull-right'>
            <i class='icon-heart'></i>
            <i class='icon-globe'></i>
          </span> #{@project.fullName()}")
        if @story
          @.$('.app-story').text(@story.fullName())
        else
          @.$('.app-story').text('')
      else
        @.$('.app-project').text('')
        @.$('.app-story').text('')

    ready: =>
      (@project and !@project.hasStories()) or  (@project and @story)

    # createDefault: =>

    #   punch = new PunchIt.Models.Punch(attributes)
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
    #     #   PunchIt.Events.trigger "savePunch"

    #   #this should be moved to a DAY view that doesn't exist or punches?
    #   $('.app-time').on 'click', (event) =>
    #     if event.altKey
    #       PunchIt.Events.trigger "startTime", $(event.currentTarget).data('time')
    #     else
    #       PunchIt.Events.trigger "stopTime", $(event.currentTarget).data('time')
