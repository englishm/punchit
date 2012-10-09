namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: =>
      @model = new PunchIt.Models.Punch
      @story = null

      PunchIt.Events.on("storyActivated", @storyActivated)
      $(@el).html("No Project/Story Selected")

    storyActivated: (story) =>
      @story = story
      $(@el).html("<strong>#{@story.get('name')}</strong>")
