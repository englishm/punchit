namespace "PunchIt.Models", (exports) ->
  class exports.Punch extends Backbone.Model
    initialize: =>
      @project = null

    info: =>
      if @project
        "#{@project.fullName()} #{@project.getStoryName(@get('story_id'))}"
      else
        "Pick a project"

    setProject: (project) =>
      @set(project_id: project.id)
      @project = project
      @project.on "storiesLoaded", =>
        @trigger("loaded")

    setStory: (story) =>
      @set(story_id: story.id)

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

    parse: (raw) =>
      id: raw['id']
      date: raw['date']
      project_id: raw.project.id
      story_id: if raw.story then raw.story.id else null
      notes: raw['notes']
      start: parseFloat(raw['start'])
      stop: parseFloat(raw['stop'])
