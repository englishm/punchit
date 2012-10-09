namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: "ul"
    className: "nav nav-list"

    initialize: =>
      $(@el).append("<li class='nav-header'>#{@model.get('fullName')}</li>")
      $(@el).append('<li><input class="app-stories" type="hidden" /></li>')

      @model.bind("reset", @populateStories)
      @model.fetchStories()

    populateStories: =>
      data = []
      @model.stories.each (story) =>
        data.push(id: story.id, text: story.get('name')) if story.get('percent_done') != 100

      $storiesTypeahead = @.$('.app-stories').select2(placeholder: "Search for a story for #{@model.get('fullName')}", data: data)

