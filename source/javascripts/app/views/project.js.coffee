namespace "PunchIt.Views", (exports) ->
  class exports.Project extends Backbone.View
    tagName: 'li'

    render: =>
      $(@el).html(@template(@model.toJSON()))
      @

    template: (args) =>
      _.template("<a><%= name %></a>")(args)
