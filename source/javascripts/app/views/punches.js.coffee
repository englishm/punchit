namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: =>
      @datePicker = $('.app-punch-date')

      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"

      @datePicker.on('changeDate', @updatePunches)
      @collection.on('reset', @refresh)
      @collection.fetch()

      $('.app-employee').on('changeData', @updatePunches)

    employeeId: =>
      $('.app-employee').data('employee-id')
      

    updatePunches: =>
      console.log "Updating punches"
      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"
      @collection.fetch()

    refresh: =>
      punchLabels = []
      @collection.each (punch) =>
        start = punch.get('start') 
        stop = punch.get('stop') 
        ticks = (stop - start) / .25

        type = punch.get
        punchLabels.push "<span class='label label-success' style='position: absolute; top: #{3 + ((start*4) * 29)}px;  width: 75%; left: 50px; height: #{(29 * ticks) - 6}px;'>#{start} #{stop} #{punch.get('notes')}</span>"

      $('.punch-table .punches').html(punchLabels)
