namespace "PunchIt.Views", (exports) ->
  class exports.Employees extends Backbone.View
    initialize: () =>
      @collection.on("reset", @refresh)

    refresh: =>
      #TODO: pull out into a helper, or put on collection
      data = []
      @collection.each (employee) =>
        data.push(id: employee.id, text: employee.get('name')) 

      @$('.app-all-employees-typeahead').select2 width: "resolve", placeholder: "Pick yourself", data: data
