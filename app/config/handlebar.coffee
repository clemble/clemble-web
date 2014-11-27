do(Handlebars, Swag, _) ->
	Swag.registerHelpers(Handlebars);

	Utils = {
		unitToString:(num, unit) ->
			if (num == 1)
				"1 #{unit}"
			else
				"#{num} #{unit}s"
		toMoney:(money) ->
			if (!money?)
				"--"
			else if (money.currency == "FakeMoney")
				"<span class='fa fa-usd'></span>#{money.amount}"
			else
				"<span class='fa fa-eur'></span>#{money.amount}"
	}

	SECOND = 1000
	MINUTE = 60 * SECOND
	HOUR = 60 * MINUTE
	DAY = 24 * HOUR
	WEEK = 7 * DAY

	Handlebars.registerHelper 'humanTime', (obj) ->
		if(obj % WEEK == 0)
			new Handlebars.SafeString(Utils.unitToString(obj / WEEK, "week"))
		else if(obj % DAY == 0)
			new Handlebars.SafeString(Utils.unitToString(obj / DAY, "day"))
		else if(obj % HOUR == 0)
			new Handlebars.SafeString(Utils.unitToString(obj / HOUR, "hour"))
		else if(obj % MINUTE == 0)
			new Handlebars.SafeString(Utils.unitToString(obj / MINUTE, "minute"))
		else
			new Handlebars.SafeString(Utils.unitToString(obj / SECOND, "second"))

	Handlebars.registerHelper 'toJSON', (obj) ->
		new Handlebars.SafeString(JSON.stringify(obj, undefined, 2))

	Handlebars.registerHelper 'gender', (g) ->
		if (g == "M")
			new Handlebars.SafeString("<span class='fa fa-male'></span>")
		else
			new Handlebars.SafeString("<span class='fa fa-female'></span>")

	Handlebars.registerHelper 'money', (money) ->
		new Handlebars.SafeString(Utils.toMoney(money))

	Handlebars.registerHelper 'bid', (bid) ->
		if(bid?)
			new Handlebars.SafeString("<span class='fa fa-credit-card'></span> #{Utils.toMoney(bid.amount)}/<small>#{Utils.toMoney(bid.interest)}</small>")
		else
			console.log("!!!ERROR!!! Trying to log empty bid")
			new Handlebars.SafeString("")

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
		ruleDay = rule.limit / DAY
		if (ruleDay = 1)
			"Daily"
		else
			"Every #{ruleDay} days"

	Handlebars.registerHelper "totalTimeRule", (rule) ->
		ruleDay = rule.limit / DAY
		if (ruleDay == 1)
			"1 Day"
		else if (ruleDay == 7)
			"Week"
		else if (ruleDay == 30)
			"Month"
		else
			"#{ruleDay} Days"

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
