namespace "PunchIt.Session", (exports) ->
  exports.getEmployeeId = =>
    $.jStorage.get 'employeeId'

  exports.setEmployeeId = (id) =>
    $.jStorage.set 'employeeId', id
    PunchIt.Events.trigger('changed:employeeId', id)

  exports.bootstrap = =>
    return if $.jStorage.get('pinnedProjectIds')

    general = 1
    lunch = 30
    vacation = 18
    holiday = 17

    $.jStorage.set('pinnedProjectIds', [general, lunch, vacation, holiday])

    dustinsId = 31
    @setEmployeeId(dustinsId)
