namespace "PunchIt.Views", (exports) ->
  class exports.AllProjects extends Backbone.View
    initialize: ({@projects, @customers}) =>
      @projects.bind("reset", @refresh)
      @customers.bind("reset", @refresh)

      console.log @projects
      console.log @customers

    # refresh: =>
    #   names = []

    #   @collection.each (project) =>
    #     names.push project.get('name') #if project.get('active')
    #       
    #   $('.app-all-projects').data('source', names)
    #   
