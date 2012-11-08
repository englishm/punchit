namespace "Punch.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: ({@projects, @calendarView}) =>
      @collection.url = "/employees/#{@employeeId()}/punches"

      Punch.Events.on("changed:employeeId", @updatePunches)

      @collection.on('reset', @refresh)
      @collection.on('add', @updateViews)
      
      #this should use events
      $('.app-punch-date').on('changeDate', @updatePunches)

      @views = {}
      @updatePunches()
      @currentDate = null


    updatePunches: =>
      if @employeeId()
        pickedDate =  Punch.Session.getDate()
        hasDateLoaded = @collection.any (punch) => pickedDate.equals(Date.parse(punch.get('date')))

        # if hasDateLoaded
        #   @refresh()
        # else
        if pickedDate.getDay() == 0
          weekStart = Punch.Session.getDate().add(-7).days()
          weekEnd = Punch.Session.getDate().add((pickedDate.getDay())).days()
        else
          weekStart = Punch.Session.getDate().add(1-pickedDate.getDay()).days()
          weekEnd = Punch.Session.getDate().add((7-pickedDate.getDay())).days()

        @collection.url = "#{Punch.Session.baseURL}/employees/#{@employeeId()}/punches?date.gte=#{weekStart.toString 'yyyy-MM-dd'}&date.lte=#{weekEnd.toString 'yyyy-MM-dd'}"
        @collection.loadPunches()
        @collection.url = "#{Punch.Session.baseURL}/employees/#{@employeeId()}/punches"

    employeeId: =>
      Punch.Session.getEmployeeId()

    updateViews: =>
      @collection.each (punch) =>
        unless @views[punch.cid]
          @views[punch.cid] = new Punch.Views.Punch(model: punch, projects: @projects)
          @views[punch.cid].render()

      @collection.each_for_date Punch.Session.getDate(), (punch) =>
        @calendarView.addEditablePunch($(@views[punch.cid].el))

      @collection.each_for_date Punch.Session.getDate().add(-1), (punch) =>
        @calendarView.addNonEditablePunch($(@views[punch.cid].el))

      #tell all the projects to get their stories so we can assume a project has a story
      _(@collection.pluck('project_id')).uniq (id) =>
        @projects.get(id).fetchStories()

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      @updateViews()

