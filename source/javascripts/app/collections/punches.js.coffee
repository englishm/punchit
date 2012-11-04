namespace "PunchIt.Collections", (exports) ->
  class exports.Punches extends Backbone.Collection
    model: PunchIt.Models.Punch
    url: "#{PunchIt.Session.baseURL}/punches"

    initialize: =>
      @projects =  arguments[1].projects

    loadPunches: =>
      @fetch(success: @loadStories)

    loadStories: =>
      projects = {}

      @each (punch) =>
        projectId = punch.get('project_id')
        project = @projects.get(projectId)
        projects[projectId] = project

      _(projects).each (project) =>
        project.fetchStories()

    activePunch: =>
      @find (punch) =>
        punch.active

    each_for_date: (date, yields) =>
      @each (punch) =>
        if date
          yields punch if date.equals(Date.parse(punch.get('date')))
        else
          yields punch

    billable: (date) =>
      billableTotal = 0
      @each_for_date date, (punch) =>
        project = @projects.get(punch.get('project_id'))
        if project and project.get('billable')
          billableTotal = billableTotal + punch.duration()

      billableTotal

    nonbillable: (date) =>
      nonBillableTotal = 0
      @each_for_date date, (punch) =>
        project = @projects.get(punch.get('project_id'))
        if project and !project.get('billable') and !project.get('personal')
          nonBillableTotal = nonBillableTotal + punch.duration()

      nonBillableTotal

    nextStartTime: (date) =>
      lastPunch = @max (punch) =>
        punch.get('stop')

      if lastPunch
        lastPunch.get('stop')
      else
        9

