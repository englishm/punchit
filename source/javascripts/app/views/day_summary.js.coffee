namespace "PunchIt.Views", (exports) ->
  class exports.DaySummary extends Backbone.View
    initialize: =>
      @collection.on("change", @refresh)
      @collection.on("reset", @refresh)
      @collection.on("remove", @refresh)
      @collection.on("add", @refresh)

    refresh: =>
      billable = @collection.billable(PunchIt.Session.getDate())
      nonbillable = @collection.nonbillable(PunchIt.Session.getDate())

      @.$('.app-hours-billable').text(billable)
      @.$('.app-hours-non-billable').text(nonbillable)
      @.$('.app-hours-total').text(billable + nonbillable)

    render: =>
      @refresh()
