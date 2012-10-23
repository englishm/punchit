namespace "PunchIt.Models", (exports) ->
  class exports.Punch extends Backbone.Model
    initialize: =>
      @project = null

    info: =>
      if @project
        "#{@project.fullName()} - #{@project.getStoryName(@get('storyId'))} - From #{@startFormatted()} to #{@stopFormatted()}"
      else
        ""

    project: =>
      @project

    setProject: (project) =>
      @project = project
      @project.on "storiesLoaded", =>
        @trigger("loaded")

    startFormatted: =>
      @get('start')

    stopFormatted: =>
      @get('stop')

