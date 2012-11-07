$ =>
  Punch.Session.onAuthenticated =>
    #TODO this should be based on 8am or current time
    # 5 per hour that it is
    window.scrollTo(0,1000)

    Punch.Session.bootstrap()

    #date finder where should this go?
    #$('.app-punch-date').datepicker()
    $('.app-punch-date').datepicker()
    $('.titled').tooltip()

    customersCollection = new Punch.Collections.Customers()
    employeesCollection = new Punch.Collections.Employees()
    projectsCollection  = new Punch.Collections.Projects(customers: customersCollection)

    bootstrap = =>
      employeesView = new Punch.Views.EmployeesModal
        collection: employeesCollection
        el: '#app-employees-modal'

      employeesView.render()

      activeEmployee = employeesCollection.get(Punch.Session.getEmployeeId())
      activeEmployeeView = new Punch.Views.Employee
        model: activeEmployee
        el: '.app-employee'
      activeEmployeeView.render()


      allProjectsView = new Punch.Views.AllProjects
        projects: projectsCollection
        el: $('#app-all-projects')
      allProjectsView.render()

      projectsRecentView = new Punch.Views.ProjectsRecent
        collection: punchesCollection
        projects: projectsCollection
        el: $('#app-recent-projects')

      projectsRecentView.render()

      caldendarView = new Punch.Views.Calendar(el: '#app-calendar')

      punchesCollection = new Punch.Collections.Punches([], projects: projectsCollection)

      daySummary = new Punch.Views.DaySummary(collection: punchesCollection, el: $('#app-day-summary'))
      weekSummary = new Punch.Views.WeekSummary(collection: punchesCollection, el: $('#app-week-summary'))
      weekSummary.render()

      punchesView = new Punch.Views.Punches
        collection: punchesCollection
        projects: projectsCollection
        calendarView: caldendarView

      newPunchView = new Punch.Views.NewPunch(el: $('#app-new-punch'), collection: punchesCollection)
      pinnedView = new Punch.Views.Pinned(el: $('#app-pinned'), projectsCollection: projectsCollection)
      pinnedView.render()

      payPeroidSummary = new Punch.Views.PayPeroidSummary(el: $('#app-pay-peroid'), collection: punchesCollection)

    # get customers then projects then employees then app. not sure a better way to do this. 
    customersCollection.fetch
      success: =>
        projectsCollection.fetch
          success: =>
            employeesCollection.fetch
              success: bootstrap
