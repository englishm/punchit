(function() {

  namespace("PunchIt.Session", function(exports) {
    var _this = this;
    exports.getEmployeeId = function() {
      return $.jStorage.get('employeeId');
    };
    exports.setEmployeeId = function(id) {
      $.jStorage.set('employeeId', id);
      return PunchIt.Events.trigger('changed:employeeId', id);
    };
    PunchIt.Session.baseURL = "https://punchitapi.atomicobject.com";
    exports.onAuthenticated = function(callback) {
      if (!exports.baseURL) {
        throw "PunchIt.Session.BaseURL is NOT set";
      }
      if (exports.baseURL === "http://localhost:4568") {
        return callback();
      } else {
        $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
          return options.xhrFields = {
            withCredentials: true
          };
        });
        return $("<img id='punchitapi-blank-img' src='" + exports.baseURL + "/blank.png?" + Number(new Date()) + "'/>").load(callback).error(function() {
          return log("You are not authenticated @ punchitapi.atomicobject.com");
        }).appendTo($('body'));
      }
    };
    exports.bootstrap = function() {
      var dustinsId, general, holiday, lunch, vacation;
      if (!$.jStorage.get('pinnedProjectIds')) {
        general = 1;
        lunch = 30;
        vacation = 18;
        holiday = 17;
        $.jStorage.set('pinnedProjectIds', [general, lunch, vacation, holiday]);
      }
      if (!$.jStorage.get('employeeId')) {
        dustinsId = 31;
        return $.jStorage.set('employeeId', dustinsId);
      }
    };
    return exports.pinProjectId = function(id) {
      var projects;
      projects = $.jStorage.get('pinnedProjectIds');
      if (_.indexOf(projects, id) < 0) {
        projects.push(id);
        return $.jStorage.set('pinnedProjectIds', projects);
      }
    };
  });

}).call(this);
