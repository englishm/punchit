namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: ({@projects, @calendarView}) =>
      @collection.url = "/employees/#{@employeeId()}/punches"

      @datePicker = $('.app-punch-date')
      @datePicker.on('changeDate', @updatePunches)

      @collection.on('reset', @refresh)
      @collection.on('add', @updateViews)
      @collection.on('change', @updateViews)

      PunchIt.Events.on("changed:employeeId", @updatePunches)

      @views = {}
      @updatePunches()

      # PunchIt.Events.on "startTime", @startPicked
      PunchIt.Events.on "stopChanged", @stopChanged
      PunchIt.Events.on "startChanged", @startChanged

      PunchIt.Events.on "startStopChanged", @startStopChanged

      PunchIt.Events.on "storyActivated", @storyActivated
      PunchIt.Events.on "projectActivated", @projectActivated
      #PunchIt.Events.on "punchClicked", @punchActivated
      

    updatePunches: =>
      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"
      @collection.loadPunches()
      @collection.url = "/employees/#{@employeeId()}/punches"

    employeeId: =>
      PunchIt.Session.getEmployeeId()

    addModel: (model) =>
      @collection.add model

    updateViews: =>
      @collection.each (punch) =>
        start = punch.get('start')
        stop = punch.get('stop')
      
        unless @views[punch.cid]
          @views[punch.cid] = new PunchIt.Views.Punch(model: punch, projects: @projects)
          @views[punch.cid].render()

        @calendarView.addEditablePunch($(@views[punch.cid].el), start, stop)

      #tell all the projects to get their stories so we can assume a project has a story
      _(@collection.pluck('project_id')).uniq (id) =>
        @projects.get(id).fetchStories()

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      @updateViews()

    projectActivated: (project) =>
      return if project.hasStories()
      @setActivePunch(project_id: project.id, story_id: null)

    storyActivated: (story) =>
      @setActivePunch(project_id: story.project_id(), story_id: story.id)

    stopChanged: (stopAdjust) =>
      punch = @collection.activePunch()
      stop = punch.get('stop')
      newStop = stop + stopAdjust
      @setActivePunch(stop: newStop)

    startChanged: (startAdjust) =>
      punch = @collection.activePunch()
      start = punch.get('start')
      newStart = start + startAdjust
      @setActivePunch(start: newStart)

    startStopChanged: (start, stop) =>
      #TODO figure out what to do with the active punch
      punch = @collection.activePunch()
      punch.deactivate() if punch

      punch = @createDefault()
      punch.set(start: start, stop: stop)

    createDefault: =>
      punch = new PunchIt.Models.Punch(date: @datePicker.val())
      punch.setStart(@collection.nextStartTime(@datePicker.val()))
      @collection.add(punch)
      punch.activate()
      punch

    setActivePunch: (newAttributes) =>
      punch = @collection.activePunch()
      punch = @createDefault() unless punch
      punch.save newAttributes, success: =>
        punch.deactivate()

