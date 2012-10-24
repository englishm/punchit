namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: ({@projects}) =>
      @datePicker = $('.app-punch-date')

      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"

      @datePicker.on('changeDate', @updatePunches)

      @collection.on('reset', @refresh)
      @collection.on('add', @refresh)

      @collection.loadPunches()

      $('.app-employee').on('changeData', @updatePunches)

      @views = {}

    employeeId: =>
      $('.app-employee').data('employee-id')

    updatePunches: =>
      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"
      @collection.loadPunches()

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

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      @collection.each (punch) =>
        start = punch.get('start')
        stop = punch.get('stop')

        @views[punch.id] ||= new PunchIt.Views.Punch(model: punch)
        view = @views[punch.id]
        @addPunch(view, start, stop)

