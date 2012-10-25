namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: ({@punchesCollection, @punchesView, @datePicker}) =>
      PunchIt.Events.on "startTime", @startPicked
      PunchIt.Events.on "stopTime", @stopPicked
      PunchIt.Events.on "storyActivated", @storyActivated
      PunchIt.Events.on "projectActivated", @projectActivated
      PunchIt.Events.on "punchClicked", @punchActivated

      @model = null

      #this should be moved to a DAY view that doesn't exist or punches?
      $('.app-time').on 'click', (event) =>
        if event.altKey
          PunchIt.Events.trigger "startTime", $(event.currentTarget).data('time')
        else
          PunchIt.Events.trigger "stopTime", $(event.currentTarget).data('time')

    punchActivated: (punch) =>
      console.log "got punch activated: #{punch}"
      @model = punch

    projectActivated: (project) =>
      console.log "updating project to #{project}"
      @model.setProject(project)

    storyActivated: (story) =>
      console.log "updating story to #{story}"
      @model.setStory(story)

    startPicked: (time) =>
      unless @model
        @model ||= new PunchIt.Models.Punch(date: @datePicker.val())
        @model.setStart parseFloat(time) + .25
        @punchesCollection.add(@model)
      else
        @model.setStart parseFloat(time) + .25

    stopPicked: (time) =>
      unless @model
        @model ||= new PunchIt.Models.Punch(date: @datePicker.val())
        @model.setStop parseFloat(time) + .25
        @punchesCollection.add(@model)
      else
        @model.setStop parseFloat(time) + .25

    # updateView: =>
    #   @view.remove()
    #   @view.render()
    #   @punchesView.addPunch(@view, @model.get('start'), @model.get('stop'))
