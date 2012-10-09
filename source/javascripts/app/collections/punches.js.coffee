namespace "PunchIt.Collections", (exports) ->
  class exports.Punches extends Backbone.Collection
    model: PunchIt.Models.Punch
    url: "/punches"
