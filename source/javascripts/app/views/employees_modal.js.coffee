namespace "PunchIt.Views", (exports) ->
  class exports.EmployeesModal extends Backbone.View
    #TODO: This should work better with firing events and hooking things with callbacks on show taking a closure
    initialize: () =>
      $('.app-all-employees-typeahead').on("change", @triggerTypeAhead)

    triggerTypeAhead: =>
      $typeAhead = $('input.app-all-employees-typeahead')
      PunchIt.Events.trigger "employeePicked", @collection.get($typeAhead.val())

    render: =>
      data = []
      @collection.each (employee) =>
        data.push(id: employee.id, text: employee.get('name'))
      $('.app-all-employees-typeahead').select2 width: "100%", placeholder: "Pick yourself", data: data
