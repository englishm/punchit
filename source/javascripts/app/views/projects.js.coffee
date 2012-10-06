namespace "PunchIt.Views", (exports) ->
  class exports.Projects extends Backbone.View
    initialize: =>
      @collection.bind("reset", @refresh)

    refresh: =>
      console.log @collection
      _.chain(@collection.sortBy((project) => project.get('name'))).each (project) =>
        if project.get('active')
          view = new PunchIt.Views.Project(model: project)
          view.render()
          $('.app-all-projects').append(view.el)
      
