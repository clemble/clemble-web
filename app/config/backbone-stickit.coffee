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

      $el.noUiSlider_pips({
        mode: 'values',
        values: options.pips,
        density: 7
      })

  update: ($el, val, model, options) ->
    _.defer ->
      $el.val model.get(options.observe)
      $el.change()
  getVal: ($el, event, options) -> $el.val()
})
#  $('#slider-tooltip').noUiSlider_pips({
#      mode: 'values',
#      values: [500000,1000000,3000000,5000000,10000000],
#      density: 4
#  });
#
#  $('.noUi-value.noUi-value-horizontal.noUi-value-large').each(function(){
#      var val = $(this).html();
#      val = recountVal(parseInt(val));
#      $(this).html(val);
#  });
