namespace "PunchIt.Views", (exports) ->
  class exports.Punches extends Backbone.View
    initialize: ({@projects, @employee}) =>
      @collection.url = "/employees/#{@employeeId()}/punches"

      @datePicker = $('.app-punch-date')
      @datePicker.on('changeDate', @updatePunches)

      @collection.on('reset', @refresh)
      @collection.on('add', @updateViews)
      @collection.on('change', @updateViews)

      PunchIt.Events.on("changed:employeeId", @updatePunches)

      @views = {}
      @updatePunches()

    updatePunches: =>
      @collection.url = "/employees/#{@employeeId()}/punches?date.gte=#{@datePicker.val()}&date.lte=#{@datePicker.val()}"
      @collection.loadPunches()
      @collection.url = "/employees/#{@employeeId()}/punches"

    employeeId: =>
      PunchIt.Session.getEmployeeId()

    addPunch: (view, start, stop) =>
      padding = 3
      ticksInHour = 4
      tickHeight = 38

      ticks = (stop - start) / .25

      $el = $(view.el)
      $el.css('top', "#{padding + ((start * ticksInHour) * tickHeight)}px")
      $el.css("height", "#{(tickHeight * ticks) - 2*padding}px")
      $('.punch-table .punches').append($el)

    addModel: (model) =>
      @collection.add model

    updateViews: =>
      @collection.each (punch) =>
        start = punch.get('start')
        stop = punch.get('stop')
      
        unless @views[punch.cid]
          @views[punch.cid] = new PunchIt.Views.Punch(model: punch, projects: @projects)
          @views[punch.cid].render()

        @addPunch(@views[punch.cid], start, stop)

      #tell all the projects to get their stories so we can assume a project has a story
      _(@collection.pluck('project_id')).uniq (id) =>
        console.log "got #{id}"
        @projects.get(id).fetchStories()

    refresh: =>
      _(@views).each (view) =>
        view.remove()

      @updateViews()



