namespace "PunchIt.Views", (exports) ->
  class exports.Punch extends Backbone.View
    tagName: "span"
    className: "label"

    initialize: =>
      @model.bind("loaded", @render)
      @model.bind("change", @refresh)

    type: =>
      if @model.isNew()
        "default"
      else if @model.project.get('billable')
        "success"
      else if @model.project.get('personal')
        "info"
      else
        "warning"


    refresh: =>
      # can this be a label-* match? 
      @$el.removeClass("label-default label-success label-info label-warning")

      @$el.addClass("label-#{@type()}")
      @$el.attr('title', @model.get('notes'))
      @$el.html("<p>#{@model.info()}</p><input type='text' />")

    render: =>
      @$el.addClass("punch")
      @$el.addClass("app-punch")
      @$el.attr('rel', 'tooltip')

      #not sure where to move this too didn't work in events
      @$el.on('click', @save)

      @refresh()

    save: =>
      @model.save()
