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

    duration: =>
      @get('stop') - @get('start')

    parse: (raw) =>
      id: raw['id']
      date: raw['date']
      project_id: raw.project.id
      story_id: if raw.story then raw.story.id else null
      notes: raw['notes']
      start: parseFloat(raw['start'])
      stop: parseFloat(raw['stop'])
