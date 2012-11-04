namespace "PunchIt.Views", (exports) ->
  class exports.ProjectsRecent extends Backbone.View
    initialize: =>
      #@collection.on 'reset', @refresh

    refresh: =>
      @collection.each (punch) =>
        @$el.html("")
        @$el.append("<li class='divider'></li>")
        @$el.append("<li class='nav-header'>
          #{punch.id}
          #{punch.get('project_id')}
          #{punch.get('story_id')}
        </li>")

