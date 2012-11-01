namespace "PunchIt.Collections", (exports) ->
  class exports.Employees extends Backbone.Collection
    model: PunchIt.Models.Employee
    url: "#{PunchIt.Session.baseURL}/employees?active=true"
