namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: ({@projects}) =>
      @collection.url = "/employees/#{@employeeId()}/punches"

      @datePicker = $('.app-punch-date')
      @datePicker.on('changeDate', @updatePunches)

      @collection.on('reset', @refresh)
      @collection.on('add', @updateViews)
      @collection.on('change', @updateViews)

      @views = {}
      $('.app-employee').on('changeData', @updatePunches)
      @updatePunches()

    employeeId: =>
      $('.app-employee').data('employee-id')

    updatePunches: =>
      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"
      @collection.loadPunches()
      @collection.url = "/employees/#{@employeeId()}/punches"

    addPunch: (view, start, stop) =>
      padding = 3
      ticksInHour = 4
      tickHeight = 38

      ticks = (stop - start) / .25

      $el = $(view.el)
      $el.css('top', "#{padding + ((start * ticksInHour) * tickHeight)}px")
      $el.css("height", "#{(tickHeight * ticks) - 2*padding}px")
      $('.punch-table .punches').append($el)

    addModel: (model) =>
      @collection.add model

    updateViews: =>
      @collection.each (punch) =>
        start = punch.get('start')
        stop = punch.get('stop')
      
        unless @views[punch.id]
          console.log "creating a new view"
          @views[punch.id] = new PunchIt.Views.Punch(model: punch)

        @addPunch(@views[punch.id], start, stop)

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      @updateViews()



