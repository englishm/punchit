namespace "PunchIt.Collections", (exports) ->
  class exports.Customers extends Backbone.Collection
    model: PunchIt.Models.Customer
    url: "/customers"
