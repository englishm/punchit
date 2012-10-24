namespace "PunchIt.Models", (exports) ->
  class exports.Punch extends Backbone.Model
    initialize: =>
      @project = null

    info: =>
      if @project
        "#{@project.fullName()} #{@project.getStoryName(@get('storyId'))}"
      else
        "Pick a project"

    setProject: (project) =>
      @project = project
      @project.on "storiesLoaded", =>
        @trigger("loaded")

    setStory: (story) =>
      @set('storyId', story.id)

    startFormatted: =>
      @get('start')

    stopFormatted: =>
      @get('stop')

    setStart: (time) =>
      if @get('stop') and time < @get('stop')
        console.log "setting start: #{time}"
        @set
          start: time
      else
        console.log "setting stop & start: #{time + .25} to #{time}"
        @set
          start: time
          stop: time + .25

    setStop: (time) =>
      if @get('start') and time > @get('stop')
        console.log "setting stop to #{time}"
        @set
          stop: time
      else
        console.log "setting stop & start: #{time + .25} to #{time}"
        @set
          stop: time
          start: time - .25
