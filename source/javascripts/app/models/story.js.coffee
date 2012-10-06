namespace "PunchIt.Models", (exports) ->
  class exports.Story extends Backbone.Model
    completed: =>
      @get('percent_done') == 100
