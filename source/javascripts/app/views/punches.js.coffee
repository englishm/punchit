namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: ({@projects, @calendarView}) =>
      @collection.url = "/employees/#{@employeeId()}/punches"

      #this shoudl go somewhere else and use Events
      @datePicker = $('.app-punch-date')
      @datePicker.on('changeDate', @updatePunches)
      PunchIt.Events.on("changed:employeeId", @updatePunches)

      @collection.on('reset', @refresh)
      @collection.on('add', @updateViews)

      @views = {}
      @updatePunches()


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
        unless @views[punch.cid]
          @views[punch.cid] = new PunchIt.Views.Punch(model: punch, projects: @projects)
          @views[punch.cid].render()

          start = punch.get('start')
          stop = punch.get('stop')
      
          @calendarView.addEditablePunch($(@views[punch.cid].el), start, stop)

      #tell all the projects to get their stories so we can assume a project has a story
      _(@collection.pluck('project_id')).uniq (id) =>
        @projects.get(id).fetchStories()

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      @updateViews()

