namespace "PunchIt.Views", (exports) ->
  class exports.Employees extends Backbone.View
    initialize: () =>
      @collection.on("reset", @refresh)
      $('.app-all-employees-typeahead').on("change", @updateEmployee)

    updateEmployee: =>
      employee = $('.app-employee')
      employee.data('employee-id', @activeEmployeeId())
      employee.find('.app-name').html(@collection.get(@activeEmployeeId()).get('name'))

    activeEmployeeId: =>
      $('input.app-all-employees-typeahead').val()


    refresh: =>
      #TODO: pull out into a helper, or put on collection
      data = []
      @collection.each (employee) =>
        data.push(id: employee.id, text: employee.get('name'))

      $('.app-all-employees-typeahead').select2 width: "resolve", placeholder: "Pick yourself", data: data
