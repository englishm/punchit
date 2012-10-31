namespace "PunchIt.Views", (exports) ->
  class exports.Calendar extends Backbone.View
    initialize: =>
      $('.app-time').on("mousedown", @mousedown).on("mouseup", @mouseup)

      @startTime = null
      @stopTime = null

    mousedown: (event) =>
      @startTime = $(event.currentTarget).data('time')

    mouseup: (event) =>
      return unless @startTime
      @stopTime = $(event.currentTarget).data('time')

      if @startTime == @stopTime
        PunchIt.Events.trigger "startStopChanged", @startTime, @startTime + .25
      if @startTime > @stopTime
        PunchIt.Events.trigger "startStopChanged", @stopTime, @startTime
      else
        PunchIt.Events.trigger "startStopChanged", @startTime, @stopTime

      @startTime = null
      @stopTime = null


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
    addEditablePunch: ($punchEl, start, stop) =>
      padding = 2
      ticksInHour = 4
      tickHeight = 38

      ticks = (stop - start) / .25

      $punchEl.css('top', "#{padding + ((start * ticksInHour) * tickHeight)}px")
      $punchEl.css("height", "#{(tickHeight * ticks) - 3*padding}px")
      @.$('.app-punches').append($punchEl)

      $punchEl.resizable
        autoHide: true
        grid: [ 0, tickHeight ]
        handles: "s, n"
        start: @resizeStarted
        stop: @resizeStopped

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

    resizeStarted: (event, ui) =>
      ui.element.trigger('touched')

    resizeStopped: (event, ui) =>
      movedStop = (ui.position.top == ui.originalPosition.top)

      if movedStop
        quarterHourChanges = ((ui.element.height() - ui.originalSize.height) / 38)
        PunchIt.Events.trigger "stopChanged", (quarterHourChanges * .25)
      else
        quarterHourChanges = ((ui.originalSize.height - ui.element.height()) / 38)
        PunchIt.Events.trigger "startChanged", (quarterHourChanges * .25)
