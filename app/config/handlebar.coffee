do(Handlebars, Swag, _) ->
	Swag.registerHelpers(Handlebars);

	SECOND = 1000
	MINUTE = 60 * SECOND
	HOUR = 60 * MINUTE
	DAY = 24 * HOUR
	WEEK = 7 * DAY

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
		humanTime: (obj) ->
			if(obj % WEEK == 0)
				Utils.unitToString(obj / WEEK, "week")
			else if(obj % DAY == 0)
				Utils.unitToString(obj / DAY, "day")
			else if(obj % HOUR == 0)
				Utils.unitToString(obj / HOUR, "hour")
			else if(obj % MINUTE == 0)
				Utils.unitToString(obj / MINUTE, "minute")
			else
				Utils.unitToString(obj / SECOND, "second")
	}

#	TODO remove after proper refactoring
	Handlebars.registerHelper "hostUrl", (path) ->
		hostUrl = "http://api.#{window.location.host}#{path}"
		new Handlebars.SafeString(hostUrl)

	Handlebars.registerHelper 'toURL', (url) ->
		new Handlebars.SafeString("http://api.#{window.location.host}#{url}")

	Handlebars.registerHelper 'showReminders', (o) ->
		reminder = ""
		reminder += if (o.emailReminderRule? && o.emailReminderRule.type != 'rule:reminder:no')
			"<span class='fa fa-send-o text-success'/> #{Utils.humanTime(o.emailReminderRule.reminder)}<br/>"
		else
			"No <span class='fa fa-send-o'></span><br/>"
		reminder += if (o.phoneReminderRule? && o.phoneReminderRule.type != 'rule:reminder:no')
			"<span class='fa fa-phone-square text-success'/> #{Utils.humanTime(o.phoneReminderRule.reminder)}"
		else
			"No <span class='fa fa-phone-square'></span>"
		new Handlebars.SafeString(reminder)

	Handlebars.registerHelper 'reminderRule', (o) ->
		if (o.type == "rule:reminder:no")
			new Handlebars.SafeString("No")
		else
			new Handlebars.SafeString("#{Utils.humanTime(o.reminder)}")

	Handlebars.registerHelper 'humanTime', (obj) ->
		new Handlebars.SafeString(Utils.humanTime(obj))

	Handlebars.registerHelper 'toJSON', (obj) ->
		new Handlebars.SafeString(JSON.stringify(obj, undefined, 2))

	Handlebars.registerHelper 'gender', (g) ->
		if (g == "M")
			new Handlebars.SafeString("<span class='fa fa-male'></span>")
		else
			new Handlebars.SafeString("<span class='fa fa-female'></span>")

	Handlebars.registerHelper 'money', (money) ->
		new Handlebars.SafeString(Utils.toMoney(money))

	Handlebars.registerHelper 'bet', (bet, icon) ->
		if(bet?)
			if (icon? && icon)
				new Handlebars.SafeString("<span class='fa fa-credit-card'></span> #{Utils.toMoney(bet.interest)}/<small>#{Utils.toMoney(bet.amount)}</small>")
			else
				new Handlebars.SafeString("#{Utils.toMoney(bet.interest)}/<small>#{Utils.toMoney(bet.amount)}</small>")
		else
			console.log("!!!ERROR!!! Trying to log empty bet")
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
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/#{player}/image' class='img-circle' height='100' width='100'></image>")

	Handlebars.registerHelper 'smallProfileImage', (player) ->
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/#{player}/image/small' class='img-circle' height='50' width='50'></image>")

	Handlebars.registerHelper 'microProfileImage', (player) ->
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/#{player}/image/small' class='img-circle' height='30' width='30'></image>")

	Handlebars.registerHelper 'myImage', (player) ->
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/my/image' class='img-circle' height='100' width='100'></image>")

	Handlebars.registerHelper 'privacyRule', (rule) ->
		if (rule == "me")
			new Handlebars.SafeString("<span class='fa fa-user'></span> me")
		else if (rule == "world")
			new Handlebars.SafeString("<span class='fa fa-globe'></span> world")
		else if (rule == "friends")
			new Handlebars.SafeString("<span class='fa fa-users'></span> friends")

	Handlebars.registerHelper "timeoutRule", (rule) ->
		if (rule? && rule.timeoutCalculator.type == "eod")
			ruleDay = rule.timeoutCalculator.days
			if (ruleDay == 1)
				new Handlebars.SafeString("1 Day")
			else if (ruleDay == 7)
				new Handlebars.SafeString("Week")
			else if (ruleDay == 30)
				new Handlebars.SafeString("Month")
			else
				new Handlebars.SafeString("#{ruleDay} Days")
		else
			new Handlebars.SafeString("Timeout rule")

	Handlebars.registerHelper "betRule", (rule) ->
		if (rule.betType == "rule:bet:fixed")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> #{rule.bets[0]}")
		else if (rule.betType == "rule:bet:limited")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> #{rule.minBet} to #{rule.maxBet}")
		else if (rule.betType == "rule:bet:unlimited")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> Unlimited")
		else if (rule.betType == "rule:bet:forbidden")
			new Handlebars.SafeString("<span class='fa fa-ban'></span> Forbidden")
		else if (rule.betType == "rule:bet:bid:mono")
			new Handlebars.SafeString("<span class='fa fa-circle-thin'></span> #{rule.bid.amount.amount}/#{rule.bid.interest.amount}")

	Handlebars.registerHelper "socialIcon", (social) ->
		if(social == "facebook")
			new Handlebars.SafeString('fa fa-facebook-square')
		else if(social == "twitter")
			new Handlebars.SafeString('fa fa-twitter-square')
		else if(social == "vkontakte")
			new Handlebars.SafeString('fa fa-vk-square')
		else if(social == "google")
			new Handlebars.SafeString('fa fa-google-plus-square')
		else if(social == "phone")
			new Handlebars.SafeString('fa fa-phone-square')
		else if(social == "email")
			new Handlebars.SafeString('fa fa-send-o')
		else if(social == "none")
			new Handlebars.SafeString('fa fa-ban')
		else
			console.error("Unknown social reference #{social}")


	Handlebars.registerHelper "socialShare", () ->
		new Handlebars.SafeString("<div class='pull-rigth'>
			<a share='facebook'><span class='fa fa-2x fa-facebook-square'></span></a>
			<a share='twitter'><span class='fa fa-2x fa-twitter-square'></span></a>
		</div>")

	Handlebars.registerHelper 'template', (t) ->
		template = require "/templates/#{t}"
		rendered = template(this)
		new Handlebars.SafeString(rendered)