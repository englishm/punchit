namespace "PunchIt.Session", (exports) ->
  exports.getEmployeeId = =>
    $.jStorage.get 'employeeId'

  exports.setEmployeeId = (id) =>
    $.jStorage.set 'employeeId', id
    PunchIt.Events.trigger('changed:employeeId', id)

  exports.bootstrap = =>
    unless $.jStorage.get('pinnedProjectIds')
      general = 1
      lunch = 30
      vacation = 18
      holiday = 17

      $.jStorage.set('pinnedProjectIds', [general, lunch, vacation, holiday])

    unless $.jStorage.get('employeeId')
      dustinsId = 31
      $.jStorage.set 'employeeId', dustinsId

  exports.pinProjectId = (id) =>
    projects = $.jStorage.get('pinnedProjectIds')
    if _.indexOf(projects, id) < 0
      projects.push id
      $.jStorage.set('pinnedProjectIds', projects)

