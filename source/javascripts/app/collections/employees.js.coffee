namespace "Punch.Collections", (exports) ->
  class exports.Employees extends Backbone.Collection
    model: Punch.Models.Employee
    url: "#{Punch.Session.baseURL}/employees?active=true"
