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
        
      @svg.data([
          personal: @collection.nonbillable()
          billable: @collection.billable()
          previous: 43
        ]).call(@chart)

      @.$('.badge.app-hours-total').text(billable + nonbillable)

    render: =>
      margin = {top: 5, right: 5, bottom: 13, left: 5}
      width = 300 - margin.left - margin.right
      height = 50 - margin.top - margin.bottom

      @chart = d3.bullet()
        .width(width - margin.right - margin.left)
        .height(height - margin.top - margin.bottom)
        .ranges(-> [36,40,50])
        .markers((d) -> [d.previous])
        .measures((d) -> [d.billable, d.billable+d.personal])

      @svg = d3.select("#app-week-summary .week-stats").selectAll("svg")
        .data([
          personal: 1
          billable: 2
          previous: 43
        ])
      .enter().append("svg")
        .attr("class", "bullet")
        .attr("width", width)
        .attr("height", height)
      .append("g")
        .attr("transform", "translate(#{margin.left},#{margin.top})")
        .call(@chart)

      @refresh()
