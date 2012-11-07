namespace "Punch.Session", (exports) ->
  #Punch.Session.baseURL = "https://punchitapi.atomicobject.com"
  Punch.Session.baseURL = "http://localhost:4568"

  exports.getEmployeeId = =>
    $.jStorage.get 'employeeId'
    
  exports.getDate = =>
    Date.parse($('.app-punch-date').val())

  exports.getDateAsString = =>
    Punch.Session.getDate().toString 'yyyy-MM-dd'

  exports.setEmployeeId = (id) =>
    $.jStorage.set 'employeeId', id
    Punch.Events.trigger('changed:employeeId', id)

  exports.onAuthenticated = (callback) =>
    throw "Punch.Session.BaseURL is NOT set" unless Punch.Session.baseURL
    if exports.baseURL == "http://localhost:4568"
      callback()
    else
      $.ajaxPrefilter (options, originalOptions, jqXHR) =>
        options.xhrFields =
          withCredentials: true

      $("<img id='punchitapi-blank-img' src='" + Punch.Session.baseURL + "/blank.png?" + Number(new Date()) + "'/>").load(callback).error( =>
        $("#app-alert-modal").modal()
      ).appendTo($('body'))
 
  exports.bootstrap = =>
    unless $.jStorage.get('pinnedProjectIds')
      general = 1
      lunch = 30
      vacation = 18
      holiday = 17

      $.jStorage.set('pinnedProjectIds', [general, lunch, vacation, holiday])

  exports.pinProjectId = (id) =>
    projects = $.jStorage.get('pinnedProjectIds')
    if _.indexOf(projects, id) < 0
      projects.push id
      $.jStorage.set('pinnedProjectIds', projects)

