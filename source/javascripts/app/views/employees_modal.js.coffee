namespace "Punch.Views", (exports) ->
  class exports.EmployeesModal extends Backbone.View
    #TODO: This should work better by taking a closure when the modal is shown.
    initialize: () =>
      $('.app-all-employees-typeahead').on("change", @triggerTypeAhead)
      @$el.on 'show', @modalShown
      @$el.modal('show') unless Punch.Session.getEmployeeId()


    modalShown: =>
      $('.app-all-employees-typeahead').focus()

    triggerTypeAhead: =>
      $typeAhead = $('input.app-all-employees-typeahead')
      employee = @collection.detect (employee) =>
        employee.get('name') == $typeAhead.val()
      Punch.Events.trigger "employeePicked", employee
      @$el.modal('hide')

    render: =>
      $('.app-all-employees-typeahead').typeahead source: @collection.pluck('name')
