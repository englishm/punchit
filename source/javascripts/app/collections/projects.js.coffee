namespace "PunchIt.Collections", (exports) ->
  class exports.Projects extends Backbone.Collection
    model: PunchIt.Models.Project
    url: "/projects?active=true"
