namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: "ul"
    className: "nav nav-list"

    initialize: =>
      $(@el).append("<li class='nav-header'>#{@model.fullName()}</li>")

      if @model.hasStories()
        $(@el).append('<li><input class="app-stories" type="hidden" /></li>')
      else
        $(@el).append('<li>No Stories</li>')

      @model.on("storiesLoaded", @populateStories)
      @model.fetchStories()

      @$('.app-stories').on("change", @storyPicked)

    storyPicked: (event) =>
      PunchIt.Events.trigger("storyActivated", @model.stories.get($(event.currentTarget).val()))

    populateStories: =>
      data = []
      @model.stories.each (story) =>
        data.push(id: story.id, text: story.get('name')) unless story.completed()

      $storiesTypeahead = @.$('.app-stories').select2(width: "resolve", placeholder: "Search for a story for #{@model.get('fullName')}", data: data)

