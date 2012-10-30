namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: ({@punchesCollection, @datePicker}) =>
      @model = null
      
      PunchIt.Events.on "startTime", @startPicked
      PunchIt.Events.on "stopTime", @stopPicked
      PunchIt.Events.on "storyActivated", @storyActivated
      PunchIt.Events.on "projectActivated", @projectActivated
      PunchIt.Events.on "punchClicked", @punchActivated


      #TODO: work with Karlin on OS detection 
      $(document).on "keypress", (event) =>
        if event.keyCode == 27
          @deactivateModel()
        else if event.keyCode == 8 and event.altKey
          @destroyModel()
          return false
        # else if event.which == 13
        # Not sure what to do with enter
        #   PunchIt.Events.trigger "savePunch"

      #this should be moved to a DAY view that doesn't exist or punches?
      $('.app-time').on 'click', (event) =>
        if event.altKey
          PunchIt.Events.trigger "startTime", $(event.currentTarget).data('time')
        else
          PunchIt.Events.trigger "stopTime", $(event.currentTarget).data('time')

    punchActivated: (punch) =>
      @deactivateModel()

      @model = punch
      @model.activate()
      @model.on("deactivate", @deactivateModel)

    deactivateModel: =>
      if @model and @model.isNew()
        @model.destroy()
      else if @model
        @model.off("deactivate", @deactivateModel)
        @model.deactivate()

      @model = null

    destroyModel: =>
      if @model
        @model.destroy()

      @model = null

    projectActivated: (project) =>
      return if project.hasStories()
      @createDefault(setDefaults: true)

      console.log "update punch"
      @model.setStory(null, project.id)

    storyActivated: (story) =>
      @createDefault(setDefaults: true)
      @model.setStory(story.id, story.project_id())

    startPicked: (time) =>
      @createDefault()
      @model.setStart parseFloat(time)

    stopPicked: (time) =>
      @createDefault()
      @model.setStop parseFloat(time) + .25

    createDefault: =>
      return unless @model == null
      punch = new PunchIt.Models.Punch(date: @datePicker.val())
      if arguments and arguments[0] and arguments[0].setDefaults
        lastPunch = @punchesCollection.max (punch) =>
          punch.get('stop')

        if lastPunch
          nextPunchStart = lastPunch.get('stop')
        else
          nextPunchStart = 8

        punch.setStart(nextPunchStart)

      @punchesCollection.add(punch)
      @punchActivated(punch)
