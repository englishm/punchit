namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: "ul"
    className: "nav nav-list"

    initialize: =>
      $(@el).append("<li class='nav-header'>#{@model.get('fullName')}</li>")
      $(@el).append('<li><input class="span4 app-stories" disabled placeholder="Find a story" type="text" data-source="" data-items="6" data-provide="typeahead"></li>')

      @model.bind("reset", @populateStories)
      @model.fetchStories()

    populateStories: =>
      $storiesTypeahead = @.$('.app-stories')
      $storiesTypeahead.data('source', @model.stories.pluck('name'))
      $storiesTypeahead.removeAttr('disabled')

