namespace "Punch.Views", (exports) ->
  class exports.PayPeroidSummary extends Backbone.View
    events:
      "click .app-day": "dayClicked"

    initialize: =>
      @collection.on("change", @refresh)
      @collection.on("reset", @refresh)
      @collection.on("remove", @refresh)
      @collection.on("add", @refresh)

      $('.app-punch-date').on('changeDate', @refresh)

    dayClicked: (element) =>
      $clickedElement = $(element.currentTarget)
      $clickedElement.addClass('active')

      day = $(element.currentTarget).data('day')
      $pickedDate = Punch.Session.getDate()
      newDate = $pickedDate.add(day - $pickedDate.getDay()).days()
      $('.app-punch-date').datepicker('setValue', newDate)
      $('.app-punch-date').trigger('changeDate')

    refresh: =>
      @.$('.app-day').removeClass('active btn-danger')

      @.$('.app-day').each (i, day) =>
        $day = $(day)
        $day.addClass('active') if $day.data('day') == Punch.Session.getDate().getDay()
