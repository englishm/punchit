namespace "Punch.Views", (exports) ->
  class exports.Calendar extends Backbone.View
    initialize: =>
      $('.app-time').on("mousedown", @mousedown).on("mouseup", @mouseup)
      @$el.attr('unselectable', 'on').css('user-select', 'none').on('selectstart', false)

      @startTime = null
      @stopTime = null
      @tickHeight = 22

    addNonEditablePunch: ($punchEl) =>
      @.$('.app-non-editable-punches').append($punchEl)

    addEditablePunch: ($punchEl) =>
      @.$('.app-editable-punches').append($punchEl)

      $punchEl.resizable
        autoHide: true
        grid: [ 0, @tickHeight ]
        handles: "s, n"
        start: @resizeStarted
        stop: @resizeStopped

    resizeStopped: (event, ui) =>
      pulledFromBottom = (ui.position.top == ui.originalPosition.top)
      if pulledFromBottom
        quarterHourChanges = ((ui.element.height() - ui.originalSize.height) / @tickHeight)
        ui.element.trigger('stopChanged', (quarterHourChanges * .25))
      else
        quarterHourChanges = ((ui.originalSize.height - ui.element.height()) / @tickHeight)
        ui.element.trigger('startChanged', (quarterHourChanges * .25))

    mousedown: (event) =>
      @startTime = parseFloat($(event.currentTarget).data('time'))

    mouseup: (event) =>
      return unless @startTime
      @stopTime = parseFloat($(event.currentTarget).data('time'))

      if @startTime == @stopTime
        #click this might need to add +25 to the star
        
        Punch.Events.trigger "startStopChanged", @startTime, @startTime + .25
      else if @startTime > @stopTime
        #click drag up
        Punch.Events.trigger "startStopChanged", @stopTime, @startTime + .25
      else
        #click drag down 
        Punch.Events.trigger "startStopChanged", @startTime, @stopTime + .25

      @startTime = null
      @stopTime = null

    # $('.app-time').droppable()
    # $('.app-time').on('drop', (event, ui) =>
    #   console.log ui.draggable
    # )

# var isDragging = false;
# $("a")
# .mousedown(function() {
#     $(window).mousemove(function() {
#         isDragging = true;
#         $(window).unbind("mousemove");
#     });
# })
# .mouseup(function() {
#     var wasDragging = isDragging;
#     isDragging = false;
#     $(window).unbind("mousemove");
#     if (!wasDragging) { //was clicking
#         $("#throbble").show();
#     }
# });

      # TODO: Hook this up
      # $punchEl.draggable
      #   axis: "y"
      #   cursor: "move"
      #   distance: 10
      #   grid: [ 0, tickHeight ]
      #   opacity: 0.5
      #   start: @dragStarted
      #   stop: @dragStopped

      # dragStarted: (event, ui) =>
      #   $(event.currentTarget).trigger('touched')

      # dragStopped: (event, ui) =>
      #   console.log "drag stopped"
