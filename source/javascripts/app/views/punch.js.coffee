namespace "PunchIt.Views", (exports) ->
  class exports.Punch extends Backbone.View
    tagName: "span"
    className: "label"


    initialize: =>
      @model.on("loaded", @render)
      #@model.on("change", @refresh)
      @$el.on('click', @clicked)


    clicked: =>
      console.log "punch activated"
      PunchIt.Events.trigger("punchClicked", @model)

    save: =>
      console.log "saving model #{@model}"
      @model.save()
        

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
      @.$('.app-info').html(@model.info())

    render: =>
      @$el.addClass("punch")
      @$el.addClass("app-punch")
      @$el.attr('rel', 'tooltip')
      @$el.html("<span class='btn btn-mini pull-right app-save'><i class='icon-edit'></i></span><p class='app-info'></p><input type='text' class='app-notes notes'  />")
      @.$('.app-save').on('click', @save)
      @refresh()
