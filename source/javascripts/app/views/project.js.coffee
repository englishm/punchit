namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: "ul"
    className: "nav nav-list"

    initialize: =>
      @model.bind("reset", @refresh)
      @model.fetchStories()
      $(@el).append("<li class='nav-header'>#{@model.get('fullName')}</li>")

    refresh: =>
      @model.stories.each (story) =>
        $(@el).append("<li><a>#{story.get('name')}</a></li>") unless story.completed()
