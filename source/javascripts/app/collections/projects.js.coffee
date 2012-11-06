namespace "Punch.Collections", (exports) ->
  class exports.Projects extends Backbone.Collection
    model: Punch.Models.Project
    url: "#{Punch.Session.baseURL}/projects"

    initialize: ({@customers}) =>
      @customers.on("reset", @loadUp)

    getCustomer: (id) =>
      @customers.get(id)

