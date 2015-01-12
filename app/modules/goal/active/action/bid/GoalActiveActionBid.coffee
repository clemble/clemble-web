@App.module "GoalActiveActionApp.GoalActiveActionBid", (GoalActiveActionBid, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		newBid: (goalKey, configuration) ->
			supporterConfiguration = _.clone(configuration.supporterConfiguration)
			supporterConfiguration.goalKey = goalKey
			supporterConfiguration.role = "supporter"

			configurations = new GoalRoleConfigurations([supporterConfiguration])

			roleModal = new RoleModal
				collection: configurations

			roleModal.on "show", () ->

				collectionRoles = new RoleConfigurations
					collection: configurations

				roleModal.configurationRegion.show collectionRoles

			App.modal.show roleModal

	class GoalRoleConfigurations extends Backbone.Collection
		setSelected: (model) =>
			# Notifying of changed selection
			if (@selected?)
				@trigger("unselected:#{@selected.get('role')}", @selected)
				@trigger("unselected", @selected)

			# Specifying new selection
			@selected = model
			@trigger("selected:#{@selected.get('role')}", @selected)
			@trigger("selected", @selected)
		getSelected: () =>
			@selected


	class RoleModal extends Marionette.LayoutView
		template: require "./templates/role_modal"
		regions:
			configurationRegion : "#configurationRegion"
		behaviors: {
			MarionetteModal: {}
		}
		events:
			'click #go' : 'go'
		go: () =>
			self = @
			model = @collection.getSelected()
			url = App.Utils.toUrl("/construction/initiation/#{model.get('goalKey')}/bid")
			role = model.get('role')
			$.ajax({
				type: 'POST',
				url: url,
				data: JSON.stringify(role),
				contentType: "application/json",
				success: () ->
					self.trigger("modal:close")
				dataType: 'json'
			})


	class RoleConfiguration extends Marionette.ItemView
		template: require './templates/role'
		tagName  : 'div'
		className: () => 'plan'
		initialize: () ->
			# In case this model was selected add active class
			@listenTo @model.collection, "selected:#{@model.get('role')}", () ->
				@$el.addClass("plan-tall")
			# In case this model was unselected remove active class
			@listenTo @model.collection, "unselected:#{@model.get('role')}", () ->
				@$el.removeClass("plan-tall")
		modelEvents:
			'sync' : 'render'
		events:
			'click': () ->
				@model.collection.setSelected(@model)

	class RoleConfigurations extends Marionette.CollectionView
		template: require './templates/roles'
		childView: RoleConfiguration
		childViewContainer: "div"

	App.reqres.setHandler "goal:active:action:bid:modal", (goalKey, configuration) -> Controller.newBid(goalKey, configuration)


