do(Handlebars, Swag, _) ->
	Swag.registerHelpers(Handlebars);

	Handlebars.registerHelper 'toJSON', (obj) ->
		new Handlebars.SafeString(JSON.stringify(obj, undefined, 2))

	Handlebars.registerHelper 'gender', (g) ->
		if (g == "M")
			new Handlebars.SafeString("<span class='fa fa-male'></span>")
		else
			new Handlebars.SafeString("<span class='fa fa-female'></span>")

	Handlebars.registerHelper 'money', (money) ->
		if (money.currency == "FakeMoney")
			new Handlebars.SafeString("<label class='label label-success'><span class='fa fa-usd'></span> #{money.amount}</label>")
		else
			new Handlebars.SafeString("<label class='label label-success'><span class='fa fa-eur'></span> #{money.amount}</label>")

	Handlebars.registerHelper 'outcome', (outcome) ->
		if (outcome.outcome == "lost")
			new Handlebars.SafeString("<span class='fa fa-circle-o'></span>")
		else if(outcome.outcome == "draw")
			new Handlebars.SafeString("<span class='fa fa-dot-circle-o'></span>")
		else if(outcome.outcome == "no")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span>")
		else if(outcome.outcome == "won")
			new Handlebars.SafeString("<span class='fa fa-check-circle-o'></span>")


	Handlebars.registerHelper 'profileImage', (player) ->
		new Handlebars.SafeString("<image src='/player/profile/#{player}/image' class='img-thumbnail'></image>")
