namespace "Punch.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: ({@projects, @calendarView}) =>
      @collection.url = "/employees/#{@employeeId()}/punches"

      #this shoudl go somewhere else and use Events
      @datePicker = $('.app-punch-date')
      Punch.Events.on("changed:employeeId", @updatePunches)

      @collection.on('reset', @refresh)
      @collection.on('add', @updateViews)
      @datePicker.on('changeDate', @updatePunches)

      @views = {}
      @updatePunches()
      @currentDate = null


    updatePunches: =>
      if @employeeId()
        pickedDate =  Date.parse(@datePicker.val())
        weekStart = Date.parse(@datePicker.val()).add(-pickedDate.getDay()).days()
        weekEnd = Date.parse(@datePicker.val()).add((7-pickedDate.getDay())).days()

        @collection.url = "#{Punch.Session.baseURL}/employees/#{@employeeId()}/punches?date.gte=#{weekStart.toString 'yyyy-MM-dd'}&date.lte=#{weekEnd.toString 'yyyy-MM-dd'}"
        @collection.loadPunches()
        @collection.url = "#{Punch.Session.baseURL}/employees/#{@employeeId()}/punches"

    employeeId: =>
      Punch.Session.getEmployeeId()

    addModel: (model) =>
      @collection.add model

    updateViews: =>
      @collection.each_for_date Punch.Session.getDate(), (punch) =>
        unless @views[punch.cid]
          @views[punch.cid] = new Punch.Views.Punch(model: punch, projects: @projects)
          @views[punch.cid].render()

        start = punch.get('start')
        stop = punch.get('stop')
        @calendarView.addEditablePunch($(@views[punch.cid].el))

      #tell all the projects to get their stories so we can assume a project has a story
      _(@collection.pluck('project_id')).uniq (id) =>
        @projects.get(id).fetchStories()

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      @updateViews()

