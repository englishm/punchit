namespace "PunchIt.Models", (exports) ->
  class exports.Punch extends Backbone.Model
    initialize: =>
      @project = null
      @active = false

    activate: =>
      @active = true
      @trigger("change")
      @trigger("activate")

    deactivate: =>
      @active = false
      @trigger("change")
      @trigger("deactivate")

    setStory: (story_id, project_id) =>
      @set
        project_id: project_id
        story_id: story_id

    setStart: (time) =>
      if @get('stop') and time < @get('stop')
        console.log "setting start: #{time}"
        @set
          start: time
      else
        console.log "setting stop & start: #{time + .25} to #{time}"
        console.log @
        @set
          start: time
          stop: time + .25

    setStop: (time) =>
      if @get('start') and time > @get('start')
        console.log "setting stop: #{time}"
        @set
          stop: time
      else
        console.log "setting start & stop: #{time - .25} to #{time}"
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
