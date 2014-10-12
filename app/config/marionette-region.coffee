do (Marionette) ->

	class ModalRegion extends Marionette.Region
		el: "#modal",

		constructor: () ->
			Marionette.Region.prototype.constructor.apply(@, arguments)
			@$el.on 'hidden', { region:this }, (event) -> event.data.region.close()

		onShow: () ->
			# TODO Supper fucking ugly do something about it
			@$el.parent().parent().parent().modal('show')

		onClose: () ->
			@$el.parent().parent().parent().modal('hide')

	Marionette.ModalRegion = ModalRegion

