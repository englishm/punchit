namespace "PunchIt.Views", (exports) ->
  class exports.Employee extends Backbone.View
    initialize: () =>
      PunchIt.Events.on "employeePicked", @updateEmployee

    updateEmployee: (employee) =>
      @model = employee
      PunchIt.Session.setEmployeeId(employee.id)
      @refresh()

    refresh: =>
      if @model
        @.$('.app-name').text(@model.get('name'))
      else
        @.$('.app-name').text("Click here to login.")

    render: =>
      @refresh()
