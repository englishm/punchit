namespace "PunchIt.Session", (exports) ->
  exports.getEmployeeId = =>
    $.jStorage.get 'employeeId'

  exports.setEmployeeId = (id) =>
    $.jStorage.set 'employeeId', id
    PunchIt.Events.trigger('changed:employeeId', id)


  PunchIt.Session.baseURL = "https://punchitapi.atomicobject.com"
  # PunchIt.Session.baseURL = "http://localhost:4568"
  # localhost
  exports.onAuthenticated = (callback) =>
    throw "PunchIt.Session.BaseURL is NOT set" unless PunchIt.Session.baseURL
    if exports.baseURL == "http://localhost:4568"
      callback()
    else
      $.ajaxPrefilter (options, originalOptions, jqXHR) =>
        options.xhrFields =
          withCredentials: true

      $("<img id='punchitapi-blank-img' src='" + PunchIt.Session.baseURL + "/blank.png?" + Number(new Date()) + "'/>").load(callback).error( =>
        log("You are not authenticated @ punchitapi.atomicobject.com")
      ).appendTo($('body'))
 
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

