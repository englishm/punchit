namespace "PunchIt.Views", (exports) ->
  class exports.Punch extends Backbone.View
    tagName: "span"
    className: "label"

    initialize: ({@projects}) =>
      @$el.on('click', @clicked)
      @model.on "change", => @refresh()
      @model.on("destroy", => @remove())
      @project().on('storiesLoaded', => @refresh()) if @project()
        
    clicked: =>
      if @model.active
        console.log "saving model #{@model}"
        @model.save(@model.attributes, success: =>
          console.log "success"
          @model.deactivate())
      else
        console.log "punch activated"
        PunchIt.Events.trigger("punchClicked", @model)

    type: =>
      if @model.isNew() or @model.active
        "default"
      else if @project().get('billable')
        "success"
      else if @project().get('personal')
        "info"
      else
        "warning"

    project: =>
      @projects.get(@model.get('project_id'))

    story: =>
      if @project()
        @project().getStory(@model.get('story_id'))

    refresh: =>
      # can this be a label-* match? 
      @$el.removeClass("label-default label-success label-info label-warning")
      @$el.addClass("label-#{@type()}")
      @.$('.app-notes').val(@model.get('notes'))

      if @project()
        @.$('.app-project').text(@project().fullName())
      else
        @.$('.app-project').text("Pick a project")

      if @story()
        @.$('.app-story').text(@story().fullName())
      else
        @.$('.app-story').text()

    render: =>
      @$el.addClass("punch")
      @$el.addClass("app-punch")
      @$el.attr('rel', 'tooltip')
      @$el.html("<p><span class='app-project'></span> <span class='app-story'></span></p><input type='text' class='app-notes notes'  />")
      #@.$('.app-save').on('click', @save)
