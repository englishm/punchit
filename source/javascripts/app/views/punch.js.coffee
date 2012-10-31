namespace "PunchIt.Views", (exports) ->
  class exports.Punch extends Backbone.View
    tagName: "span"
    className: "label"

    initialize: ({@projects}) =>
      @model.on "change", => @refresh()
      @model.on("destroy", => @remove())
      @project().on('storiesLoaded', => @refresh()) if @project()

    type: =>
      if @model.isNew()
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
      @$el.removeClass("active label-default label-success label-info label-warning")
      @$el.addClass("label-#{@type()}")
      @$el.addClass("active") if @model.active
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
      @$el.html("
        <p>
          <span class='punch-controls pull-right'>
            <i class='app-activate icon-edit icon-white'></i>
            <i class='app-remove icon-remove icon-white'></i>
          </span>
          <span class='app-project'></span>
          <span class='app-story'></span>
        </p>
        <input type='text' class='app-notes notes'  />
      ")

      @.$('.app-activate').on 'click', =>
        if @model.active
          @model.deactivate()
        else
          @model.activate()

      @.$('.app-remove').on 'click', =>
        @model.destroy()

      @$el.on 'touched', =>
        @model.activate()
