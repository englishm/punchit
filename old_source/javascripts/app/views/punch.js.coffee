namespace "PunchIt.Views", (exports) ->
  class exports.Punch extends Backbone.View
    tagName: "span"
    className: "label"

    initialize: =>
      @model.bind("loaded", @render)

    type: =>
      if @model.project.get('billable')
        "success"
      else if @model.project.get('personal')
        "info"
      else
        "warning"

    render: =>
      @$el.addClass("punch")
      @$el.addClass("label-#{@type()}")
      @$el.attr('rel', 'tooltip')
      @$el.attr('title', @model.get('notes'))
      @$el.html(@model.info())
