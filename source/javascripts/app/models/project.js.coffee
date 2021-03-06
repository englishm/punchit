namespace "Punch.Models", (exports) ->
  class exports.Project extends Backbone.Model
    initialize: =>
      @customer = @collection.getCustomer(@get('customerId'))
      @stories = new Punch.Collections.Stories()
      @stories.url = "#{Punch.Session.baseURL}#{@get('storiesUrl')}"
      @stories.bind("reset", => @trigger("storiesLoaded"))

    stories: =>
      @stories

    fetchStories: =>
      if !@hasStories
        @trigger("storiesLoaded")
      else if @stories.length > 0
        @trigger("storiesLoaded")
      else
        @stories.fetch()

    storiesLoaded: =>
      @stories.length > 0

    hasStories: =>
      @get('has_stories')

    fullName: =>
      "#{@customer.get('name')} #{@get('name')}"

    isPunchable: =>
      @get('active') && !@isSales()

    getStory: (id) =>
      @stories.get(id) if id and @hasStories()
      
    isSales: =>
      @get('opportunity_identifier') != null

    parse: (rawResponse) =>
      if rawResponse['phase']
        rawResponse["storiesUrl"] = "#{rawResponse['phase'].$ref}/stories"
      else
        rawResponse["storiesUrl"] = rawResponse['stories'].$ref
      rawResponse["customerId"] = rawResponse["customer"].id
      rawResponse
