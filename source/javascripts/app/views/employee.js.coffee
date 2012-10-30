namespace "PunchIt.Views", (exports) ->
  class exports.Employee extends Backbone.View
    initialize: () =>
      PunchIt.Events.on "employeePicked", @updateEmployee

    updateEmployee: (employee) =>
      @model = employee
      PunchIt.Session.setEmployeeId(employee.id)
      @refresh()

    refresh: =>
      @.$('.app-name').html(@model.get('name'))

    render: =>
      @refresh()
