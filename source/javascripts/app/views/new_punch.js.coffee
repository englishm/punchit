namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: ({@punchesView}) =>
      @view = null
      @model = new PunchIt.Models.Punch()

      #this should be stored on the model
      PunchIt.Events.on "timePicked", @timePicked
      PunchIt.Events.on "storyActivated", @storyActivated
      PunchIt.Events.on "projectActivated", @projectActivated

      #this should be moved
      $('.app-time').on 'click', (event) =>
        PunchIt.Events.trigger "timePicked", $(event.currentTarget).data('time')


    projectActivated: (project) =>
      @model.setProject(project)

    storyActivated: (story) =>
      @model.setStory(story)

    timePicked: (time) =>
      if @view
        console.log "another click"
      else
        @view = new PunchIt.Views.Punch(model: @model)
        @view.render()

        @model.set('start', time)
        @model.set('stop', time + .25)
        console.log(time + .25)

        @punchesView.addPunch(@view, time, time + .25)
      # if @acceptsTime()
      #   if @.$('.app-start').html() == ''
      #     @start = time
      #     @.$('.app-start').html(time)
      #   else
      #     @stop = time

      #     @collection.create(
      #       project_id: @project.id
      #       story_id: @story.id if @story
      #       date: @datePicker.val()
      #       start: @start
      #       stop: @stop
      #       notes: "punching from FacePunch"
      #     ,
      #       success: @collection.loadStories
      #     )

      #     @resetPunch()

