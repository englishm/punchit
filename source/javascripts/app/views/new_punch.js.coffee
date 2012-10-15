namespace "PunchIt.Views", (exports) ->
  class exports.NewPunch extends Backbone.View
    initialize: =>
      @model = new PunchIt.Models.Punch
      @project = null
      @story = null

      PunchIt.Events.on("storyActivated", @storyActivated)
      PunchIt.Events.on("projectActivated", @projectActivated)
      $(@el).html("No Project/Story Selected")

    projectActivated: (project) =>
      console.log project
      @project = project
      $(@el).html("<strong>#{@project.fullName()}</strong>")

    storyActivated: (story) =>
      @story = story
      $(@el).html("<strong>#{@story.get('name')}</strong>")
