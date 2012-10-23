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

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      padding = 3
      ticksInHour = 4
      tickHeight = 30

      punchLabels = []


      @collection.each (punch) =>
        start = punch.get('start')
        stop = punch.get('stop')
        ticks = (stop - start) / .25

        @views[punch.id] ||= new PunchIt.Views.Punch(model: punch)
        view = @views[punch.id]

        $el = $(view.el)
        $el.css('top', "#{padding + ((start * ticksInHour) * tickHeight)}px")
        $el.css("height", "#{(tickHeight * ticks) - 2*padding}px")
        $('.punch-table .punches').append($el)
