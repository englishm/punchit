namespace "Punch.Collections", (exports) ->
  class exports.Customers extends Backbone.Collection
    model: Punch.Models.Customer
    url: "#{Punch.Session.baseURL}/customers"
