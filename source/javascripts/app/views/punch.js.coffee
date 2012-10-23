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
      @$el.addClass("label-#{@type()}")
      @$el.attr('rel', 'tooltip')
      @$el.attr('title', @model.get('notes'))
      @$el.html(@model.info())

    render: =>
      @$el.addClass("punch")
      @refresh()
