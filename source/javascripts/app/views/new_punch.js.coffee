namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: =>
      #this should be stored on the model
      
      @datePicker = $('.app-punch-date')
      @project = null
      @story = null
      @start = null
      @stop = null

      PunchIt.Events.on "storyActivated", @storyActivated
      PunchIt.Events.on "projectActivated", @projectActivated
      PunchIt.Events.on "timePicked", @timePicked

      #this should be moved
      $('.app-time').on 'click', @timeClicked

    timeClicked: (event) =>
      PunchIt.Events.trigger "timePicked", $(event.currentTarget).data('time')


    projectActivated: (project) =>
      @project = project
      @clearStory()
      @.$('.app-project').html("<strong>#{@project.fullName()}</strong>")

    clearStory: =>
      @story = null
      @.$('.app-story').html("")

    storyActivated: (story) =>
      @story = story
      @.$('.app-story').html("- <strong>#{@story.get('name')}</strong>")


    resetPunch: =>
      @start = null
      @stop = null

      @.$('.app-start').html("")
      @.$('.app-stop').html("")

    acceptsTime: =>
      if @project == null
        false
      else if @project.hasStories() and @story == null
        false
      else
        true

    projectId: =>
      @project.id

    storyId: =>
      if @story then @story.id else null

    timePicked: (time) =>
      if @acceptsTime()
        if @.$('.app-start').html() == ''
          @start = time
          @.$('.app-start').html(time)
        else
          @stop = time

          @collection.create(
            project_id: @project.id
            story_id: @story.id if @story
            date: @datePicker.val()
            start: @start
            stop: @stop
            notes: "punching from FacePunch"
          ,
            success: @collection.loadStories
          )

          @resetPunch()

