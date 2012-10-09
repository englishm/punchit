namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: "ul"
    className: "nav nav-list"

    initialize: =>
      $(@el).append("<li class='nav-header'>#{@model.get('fullName')}</li>")
      $(@el).append('<li><input class="app-stories" type="hidden" /></li>')

      @model.on("reset", @populateStories)
      @model.fetchStories()

      @$('.app-stories').on("change", @storyPicked)

    storyPicked: (event) =>
      story = @model.stories.get($(event.currentTarget).val())
      $('#active-story').html("<strong>#{story.get('name')}</strong><span class='pull-right'><span class='button'><i class='icon-star'></i></span><i class='icon-globe'></i><i class='icon-fire'></i></span>")

    populateStories: =>
      data = []
      @model.stories.each (story) =>
        data.push(id: story.id, text: story.get('name')) if story.get('percent_done') != 100

      $storiesTypeahead = @.$('.app-stories').select2(placeholder: "Search for a story for #{@model.get('fullName')}", data: data)

