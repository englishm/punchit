namespace "PunchIt.Models", (exports) ->
  class exports.Story extends Backbone.Model
    completed: =>
      @get('percent_done') == 100

    project_id: =>
      @get('project').id

    fullName: =>
      @get('name')
