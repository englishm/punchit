namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: ({@punchesView}) =>
      @model = new PunchIt.Models.Punch(notes: 'doooo it')
      @view = new PunchIt.Views.Punch(model: @model)

      #this should be stored on the model
      PunchIt.Events.on "startTime", @startPicked
      PunchIt.Events.on "stopTime", @stopPicked

      PunchIt.Events.on "storyActivated", @storyActivated
      PunchIt.Events.on "projectActivated", @projectActivated

      @model.on "change", @updateView
      @view.on "notesSave", @doIt

      #this should be moved to a DAY view that doesn't exist or punches?
      $('.app-time').on 'click', (event) =>
        if event.altKey
          PunchIt.Events.trigger "startTime", $(event.currentTarget).data('time')
        else
          PunchIt.Events.trigger "stopTime", $(event.currentTarget).data('time')

    projectActivated: (project) =>
      @model.setProject(project)

    storyActivated: (story) =>
      @model.setStory(story)

    startPicked: (time) =>
      @model.setStart parseFloat(time)

    stopPicked: (time) =>
      @model.setStop parseFloat(time) + .25

    #TODO this should probably also be in the punches view
    updateView: =>
      @view.remove()
      @view.render()
      @punchesView.addPunch(@view, @model.get('start'), @model.get('stop'))


    doIt: =>
      @collection.add(@model, success: =>
        @collection.loadStories()
        @updateView())
