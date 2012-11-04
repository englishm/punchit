namespace "PunchIt.Views", (exports) ->
  class exports.WeekSummary extends Backbone.View
    initialize: =>
      @collection.on("change", @refresh)
      @collection.on("reset", @refresh)
      @collection.on("remove", @refresh)
      @collection.on("add", @refresh)

      sunday = '2012-10-28'
      saturday = '2012-11-03'
      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{sunday}&date.lte=#{saturday}"
      @collection.loadPunches()

    refresh: =>
      billable = @collection.billable()
      nonbillable = @collection.nonbillable()

      @.$('.progress .app-hours-billable').width("#{billable * 2}%")
      @.$('.progress .app-hours-non-billable').width("#{nonbillable * 2}%")

      @.$('.badge.app-hours-billable').text(billable)
      @.$('.badge.app-hours-non-billable').text(nonbillable)
      @.$('.badge.app-hours-total').text(billable + nonbillable)

    render: =>
      @refresh()

    employeeId: =>
      PunchIt.Session.getEmployeeId()
