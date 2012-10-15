namespace "PunchIt.Models", (exports) ->
  class exports.Project extends Backbone.Model
    initialize: =>
      @customer = @collection.getCustomer(@get('customerId'))
      @stories = new PunchIt.Collections.Stories()
      @stories.url = @get('storiesUrl')
      @stories.bind("reset", => @trigger("reset"))

    stories: =>
      @stories

    fetchStories: =>
      @stories.fetch()

    fullName: =>
      "#{@customer.get('name')} #{@get('name')}"

    isPunchable: =>
      @get('active') && !@isSales()
      
    isSales: =>
      @get('opportunity_identifier') != null

    parse: (rawResponse) =>
      rawResponse["storiesUrl"] = rawResponse['stories'].$ref
      rawResponse["customerId"] = rawResponse["customer"].id
      rawResponse



