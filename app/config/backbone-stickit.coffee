Backbone.Stickit.addHandler(  {
  selector: '.slider',
  events: ['change'],
  initialize: ($el, model, options) ->
    options.sliderOptions ||= {}
    if typeof options.sliderOptions is 'function'
      options.sliderOptions = options.sliderOptions model
    $el.noUiSlider _.extend {
      range: [0, 100]
      start: model.get(options.observe)
      step: 1
      handles: 1
      connect: 'lower'
      slide: -> _.defer -> $el.trigger('change')
    }, options.sliderOptions
  update: ($el, val, model, options) ->
    _.defer ->
      $el.val model.get(options.observe)
      $el.change()
  getVal: ($el, event, options) -> $el.val()
})