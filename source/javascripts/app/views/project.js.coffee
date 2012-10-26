namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: "ul"
    className: "nav nav-list"

    events:
      "click app-pick": "projectClicked"


    initialize: =>
      if @model.hasStories()
        $(@el).append("<li class='nav-header app-project'>#{@model.fullName()}</li>")
        $(@el).append('<li><input class="app-stories" type="hidden" /></li>')

        @model.on("storiesLoaded", @populateStories)
        @model.fetchStories()
        @$('.app-stories').on("change", @storyPicked)
      else
        $(@el).append("<li class='nav-header app-project'>#{@model.fullName()}<span class='btn btn-mini pull-right'><i class='icon-share-alt'></i></span></li>")
        $(@el).on('click', => @projectClicked())



    storyPicked: (event) =>
      PunchIt.Events.trigger("storyActivated", @model.stories.get($(event.currentTarget).val()))

    projectClicked: =>
      console.log "picked"
      PunchIt.Events.trigger "projectActivated", @model

    populateStories: =>
      data = []
      @model.stories.each (story) =>
        data.push(id: story.id, text: story.get('name')) unless story.completed()

      $storiesTypeahead = @.$('.app-stories').select2(width: "resolve", placeholder: "Search for a story for #{@model.get('fullName')}", data: data)

