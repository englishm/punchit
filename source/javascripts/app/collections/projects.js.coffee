namespace "PunchIt.Collections", (exports) ->
  class exports.Projects extends Backbone.Collection
    model: PunchIt.Models.Project
    url: "/projects"

    initialize: ({@customers}) =>
      @customers.on("reset", @loadUp)
      @customers.fetch()

    loadUp: =>
      @fetch()

    getCustomer: (id) =>
      @customers.get(id)

