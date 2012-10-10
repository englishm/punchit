namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: =>
      @collection.url = "/employees/31/punches?date.gte=2012-10-08&date.lte=2012-10-08"
      @collection.fetch()
      console.log @collection
