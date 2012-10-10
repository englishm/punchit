namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: =>
      @datePicker = $('.app-punch-date')
      @employeePicker = $('.app-all-employees-typeahead')

      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"

      @datePicker.on('changeDate', @updatePunches)
      @employeePicker.on('change', @updatePunches)

      @collection.on('reset', @refresh)
      @collection.fetch()


    employeeId: =>
      if @employeePicker.val()
        @employeePicker.val()
      else
        31

    updatePunches: =>
      console.log "Updating punches"
      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"
      @collection.fetch()

    refresh: =>
      @collection.each (punch) =>
        start = punch.get('start') 
        stop = punch.get('stop') 
        ticks = (stop - start) / .25

        type = punch.get
        punchLabel = "<span class='label label-success' style='position: absolute; top: #{3 + ((start*4) * 29)}px;  width: 75%; left: 50px; height: #{(29 * ticks) - 6}px;'>#{start} #{stop} #{punch.get('notes')}</span>"
        $('.punch-table .punches').prepend(punchLabel)
