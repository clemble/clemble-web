do(Handlebars, Swag, _) ->
	Swag.registerHelpers(Handlebars);

	Handlebars.registerHelper 'gender', (g) ->
		if (g == "M")
			new Handlebars.SafeString("<span class='fa fa-male'></span>")
		else
			new Handlebars.SafeString("<span class='fa fa-female'></span>")

	Handlebars.registerHelper 'money', (currency, money) ->
		if (currency == "FakeMoney")
			new Handlebars.SafeString("<label class='label label-success'><span class='fa fa-usd'></span> #{money.amount}</label>")
		else
			new Handlebars.SafeString("<label class='label label-default'><span class='fa fa-euro'></span> #{money.amount}</label>")
