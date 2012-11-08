namespace "Punch.Views", (exports) ->
  class exports.Error extends Backbone.View
    initialize: =>
      @$el.ajaxError @error
      @$el.ajaxSuccess @clear
      
    error: (event, request, settings, thrownError) =>
      @$el.removeClass('hide')
      @$el.text(@parseResponseText(request.responseText))
      setTimeout(@clear, 4000)

    clear: =>
      @$el.addClass('hide')
      @$el.text("")

    parseResponseText: (text) =>
      parsedResponse = $.parseJSON(text)
      errorsText = ""
      
      _.each parsedResponse, (errors, key) =>
        errorsText = _.reduce errors, (allErrors, error) =>
          return "#{allErrors} #{error}"
      return errorsText
      
