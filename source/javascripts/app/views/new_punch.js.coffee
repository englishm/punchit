namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: ({@punchesCollection, @datePicker}) =>
      @model = null
      
      PunchIt.Events.on "startTime", @startPicked
      PunchIt.Events.on "stopTime", @stopPicked
      PunchIt.Events.on "storyActivated", @storyActivated
      PunchIt.Events.on "projectActivated", @projectActivated
      PunchIt.Events.on "punchClicked", @punchActivated

      $(document).on "keypress", (event) =>
        if event.which == 0
          @clearModel()
        else if event.which == 13
          PunchIt.Events.trigger "savePunch"

      #this should be moved to a DAY view that doesn't exist or punches?
      $('.app-time').on 'click', (event) =>
        if event.altKey
          PunchIt.Events.trigger "startTime", $(event.currentTarget).data('time')
        else
          PunchIt.Events.trigger "stopTime", $(event.currentTarget).data('time')

    punchActivated: (punch) =>
      @clearModel()

      @model = punch
      @model.activate()
      @model.on("deactivate", @clearModel)

    clearModel: =>
      if @model and @model.isNew()
        @model.destroy()
      else if @model
        @model.off("deactivate", @clearModel)
        @model.deactivate()

      @model = null

    projectActivated: (project) =>
      return unless @model
      return if project.hasStories()

      console.log "update punch"
      @model.setStory(null, project.id)

    storyActivated: (story) =>
      return unless @model
      console.log "updating story to"
      console.log story
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
      @punchesCollection.add(punch)
      @punchActivated(punch)
