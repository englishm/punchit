namespace "PunchIt.Collections", (exports) ->
  class exports.Employees extends Backbone.Collection
    model: PunchIt.Models.Employee
    url: "/employees?active=true"
