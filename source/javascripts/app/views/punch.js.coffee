namespace "Punch.Views", (exports) ->
  class exports.Punch extends Backbone.View
    tagName: "span"
    className: "label punch app-punch"

    initialize: ({@projects}) =>
      @model.on "change", => @refresh()
      @model.on "destroy", => @remove()

      @project().on('storiesLoaded', => @refresh()) if @project()

      @$el.on 'stopChanged', (event, time) =>
        newStop = @model.get('stop') + time
        @model.set(stop: newStop)
        @save()

      @$el.on 'startChanged', (event, time) =>
        newstart = @model.get('start') + time
        @model.set(start: newstart)
        @save()

    save: =>
      @model.save()


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

    notesChanged: (event) =>
      #TODO this should change and not count on the blur to be hooked up!
      if (event.keyCode == 13)
        @.$('.app-notes').blur()
      else
        true

    saveNotes: =>
      $notes = @.$('.app-notes')
      @model.set(notes: $notes.val())
      @save()
      true

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
        @.$('.app-story').text('')

    render: =>
      @$el.attr('rel', 'tooltip')
      @$el.attr('duration', @model.duration())
      @$el.attr('start', @model.get('start'))
      @$el.html("
      <span class='punch-controls pull-right'>
        <i class='app-remove icon-remove icon-white'></i>
      </span>
      <p>
        <span class='app-info'>
          <i class='icon-map-marker icon-white'></i>
          <span class='app-project'></span>
          <span class='app-story'></span>
        </span>
        <input type='text' class='app-notes notes' placeholder='No Notes' />
      </p>")
      

      @.$('.app-info').on 'click', =>
        window.Punch.Events.trigger("punchableActivated", @project(), @story())

      @.$('.app-remove').on 'click', =>
        @model.destroy()

      @.$('.app-notes').on 'keypress', @notesChanged
      @.$('.app-notes').on 'blur', @saveNotes

