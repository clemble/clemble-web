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
			new Handlebars.SafeString("<span class='fa fa-usd'></span>#{money.amount}")
		else
			new Handlebars.SafeString("<span class='fa fa-eur'></span>#{money.amount}")

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
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/#{player}/image' class='img-thumbnail'></image>")

	Handlebars.registerHelper 'smallProfileImage', (player) ->
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/#{player}/image/small' class='img-thumbnail'></image>")

	Handlebars.registerHelper 'myImage', (player) ->
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/my/image' class='img-thumbnail'></image>")

	Handlebars.registerHelper 'privacyRule', (rule) ->
		if (rule == "me")
			new Handlebars.SafeString("<span class='fa fa-user'></span> me")
		else if (rule == "world")
			new Handlebars.SafeString("<span class='fa fa-globe'></span> world")
		else if (rule == "friends")
			new Handlebars.SafeString("<span class='fa fa-users'></span> friends")

	Handlebars.registerHelper "moveTimeRule", (rule) ->
		days = rule.limit / 86400000
		if (days = 1)
			"Daily"
		else
			"Every #{days} days"

	Handlebars.registerHelper "totalTimeRule", (rule) ->
		days = rule.limit / 86400000
		if (days == 1)
			"1 Day"
		else if (days == 7)
			"Week"
		else if (days == 30)
			"Month"
		else
			"#{days} Days"

	Handlebars.registerHelper "betRule", (rule) ->
		if (rule.betType == "fixed")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> #{rule.bets[0]}")
		else if (rule.betType == "limited")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> #{rule.minBet} to #{rule.maxBet}")
		else if (rule.betType == "unlimited")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> Unlimited")
		else if (rule.betType == "forbidden")
			new Handlebars.SafeString("<span class='fa fa-ban'></span> Forbidden")
		else if (rule.betType == "rule:bet:bid:mono")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> #{rule.bid.amount.amount}/#{rule.bid.interest.amount}")
