Backbone.Stickit.addHandler(  {
  selector: '.slider',
  events: ['change'],
  initialize: ($el, model, options) ->
    options.sliderOptions ||= {}
    if typeof options.sliderOptions is 'function'
      options.sliderOptions = options.sliderOptions model
    $el.noUiSlider(_.extend {
      range: [0, 100]
      start: model.get(options.observe)
      step: 1
      handles: 1
      connect: 'lower'
      slide: -> _.defer -> $el.trigger('change')
    }, options.sliderOptions)
    if (options.pips?)
      if typeof options.pips is 'function'
        options.pips = options.pips model

      values = _.map(options.pips, (pip) -> pip.value)

      $el.noUiSlider_pips({
        mode: 'values',
        values: values,
        density: 10
      })

      for el, i in $el.find('.noUi-value.noUi-value-horizontal.noUi-value-large')
        label = options.pips[i].label
        $(el).html("#{label}")

  update: ($el, val, model, options) ->
    _.defer ->
      $el.val model.get(options.observe)
      $el.change()
  getVal: ($el, event, options) -> $el.val()
})

