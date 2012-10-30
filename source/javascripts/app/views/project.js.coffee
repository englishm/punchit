namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: "li"
    className: "project"

    events:
      "click app-pick": "projectClicked"

    initialize: =>
      if @model.hasStories()
        #$(@el).append("<li class='nav-header app-project'>#{@model.fullName()}</li>")
        $(@el).html('<input class="app-stories input-xxlarge" type="hidden" />')

        @model.on("storiesLoaded", @populateStories)
        @model.fetchStories()
        @$('.app-stories').on("change", @storyPicked)
      else
        $(@el).html("<a><span class='btn btn-mini'><i class='icon-share-alt'></i></span>#{@model.fullName()}</a>")
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

      $storiesTypeahead = @.$('.app-stories').select2(width: "100%", placeholder: "Search for a story for #{@model.fullName()}", data: data)

