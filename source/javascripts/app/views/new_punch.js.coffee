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
      @.$('.app-project').html("<strong>#{@project.fullName()}</strong>")

    storyActivated: (story) =>
      @story = story
      @.$('.app-story').html("- <strong>#{@story.get('name')}</strong>")


    resetPunch: =>
      @project = null
      @story = null
      @start = null
      @stop = null

      @.$('.app-start').html("")
      @.$('.app-stop').html("")
      @.$('.app-project').html("Nada")
      @.$('.app-story').html("")

    acceptsTime: =>
      if @project == null
        false
      else if @story == null and @project.hasStories()
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
          @.$('.app-start').html(time)
        else
          console.log "punching"

          console.log @project
          console.log @project.id

          console.log @story
          console.log @story.id

          @collection.create(project_id: @project.id, story_id: @story.id, date: @datePicker.val(), start: @start, stop: @stop, notes: "punching from FacePunch")
          @resetPunch()

