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
        $(@el).html("<a href='##{@model.id}'>#{@model.fullName()}</a>")
        $(@el).on('click', => @projectClicked())

    storyPicked: (event) =>
      PunchIt.Events.trigger "punchableActivated", @model, @model.stories.get($(event.currentTarget).val())

    projectClicked: =>
      PunchIt.Events.trigger "punchableActivated", @model, null

    populateStories: =>
      data = []
      @model.stories.each (story) =>
        data.push(id: story.id, text: story.get('name')) unless story.completed()

      $storiesTypeahead = @.$('.app-stories').select2
        width: "100%"
        placeholder: "Search for a story for #{@model.fullName()}"
        data: data
        allowClear: true

