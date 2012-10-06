namespace "PunchIt.Models", (exports) ->
  class exports.Project extends Backbone.Model
    initialize: =>
      @customer = null
      @stories = new PunchIt.Collections.Stories()
      @stories.url = @get('stories').$ref
      @stories.bind("reset", => @trigger("reset"))

    setCustomer: (customer) =>
      @customer = customer
      @.set("fullName", @fullNameWithCustomer())

    stories: =>
      @stories

    fetchStories: =>
      @stories.fetch()

    fullNameWithCustomer: =>
      "#{@customer.get('name')} #{@get('name')}"

    parse: (rawResponse) =>
      rawResponse["customerId"] = rawResponse["customer"].id
      rawResponse



