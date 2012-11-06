namespace "Punch.Views", (exports) ->
  class exports.WeekSummary extends Backbone.View
    initialize: =>
      @collection.on("change", @refresh)
      @collection.on("reset", @refresh)
      @collection.on("remove", @refresh)
      @collection.on("add", @refresh)
      @svg = null
      @chart = null

    refresh: =>
      billable = @collection.billable()
      nonbillable = @collection.nonbillable()

      margin = {top: 5, right: 5, bottom: 13, left: 5}
      width = 300 - margin.left - margin.right
      height = 50 - margin.top - margin.bottom
        
      console.log @svg.datum()

      @svg.data([
          personal: @collection.nonbillable()
          billable: @collection.billable()
          previous: 40
        ]).call(@chart)

      console.log @svg.datum()
      # @.$('.progress .app-hours-billable').width("#{billable * 2}%")
      # @.$('.progress .app-hours-non-billable').width("#{nonbillable * 2}%")
 
      @.$('.badge.app-hours-billable').text(billable)
      @.$('.badge.app-hours-non-billable').text(nonbillable)
      @.$('.badge.app-hours-total').text(billable + nonbillable)

    render: =>
      margin = {top: 5, right: 5, bottom: 13, left: 5}
      width = 300 - margin.left - margin.right
      height = 50 - margin.top - margin.bottom

      @chart = d3.bullet()
        .width(width - margin.right - margin.left)
        .height(height - margin.top - margin.bottom)
        .ranges(-> [40,50,60])
        .markers((d) -> [d.previous])
        .measures((d) -> [d.personal, d.billable+d.personal])

      console.log(@chart)

      @svg = d3.select("#app-week-summary .week-stats").selectAll("svg")
        .data([
          personal: 1
          billable: 2
          previous: 40
        ])
      .enter().append("svg")
        .attr("class", "bullet")
        .attr("width", width)
        .attr("height", height)
      .append("g")
        .attr("transform", "translate(#{margin.left},#{margin.top})")
        .call(@chart)

      @refresh()

    employeeId: =>
      Punch.Session.getEmployeeId()
