namespace "PunchIt.Views", (exports) ->
  class exports.DaySummary extends Backbone.View
    initialize: =>
      @collection.on("change", @refresh)
      @collection.on("reset", @refresh)
      @collection.on("remove", @refresh)
      @collection.on("add", @refresh)

    refresh: =>
      @.$('.app-hours-billable').text(@collection.billable())
      @.$('.app-hours-non-billable').text(@collection.nonbillable())
      @.$('.app-hours-total').text(@collection.billable() + @collection.nonbillable())

    render: =>
      @refresh()
