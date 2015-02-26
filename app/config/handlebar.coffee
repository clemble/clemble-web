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
			else if (money.currency == "point")
				"<span class='fa fa-usd'></span> #{money.amount}"
			else
				"<span class='fa fa-euro'></span> #{money.amount}"
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
		punishment: (obj) ->
			if (obj.breach == "penalty")
				- obj.amount.amount
			else if(obj.breach == "loose")
				"loose"
			else
				"unknown"
		socialIcon: (social) ->
			if (social == "facebook")
				'fa fa-facebook'
			else if (social == "twitter")
				'fa fa-twitter'
			else if (social == "vkontakte")
				'fa fa-vk'
			else if (social == "google")
				'fa fa-google-plus'
			else if (social == "phone")
				'fa fa-phone'
			else if (social == "email")
				'fa fa-send-o'
			else
				'fa fa-exclamation'
		ruleToIcon: (rule) ->
			if (rule.type == "rule:privacy")
				if (rule.name == "me")
					'fa fa-user'
				else if (rule.name == "world")
					'fa fa-globe'
				else if (rule.name == "friends")
					'fa fa-users'
			else if (rule.type == "rule:role:configuration")
				'fa fa-ticket'
			else if (rule.type == "rule:timeout")
				if (rule.timeoutCalculator.type == "eod")
					ruleDay = rule.timeoutCalculator.days
					if (ruleDay == 1)
						'fa fa-circle'
					else if (ruleDay == 2)
						'fa fa-adjust'
					else
						'fa fa-circle-thin'
				else if (rule.timeoutCalculator.type == "move")
					'fa fa-clock-o'
				else
				 'fa fa-ban'
			else if (rule.type == "rule:share")
				if (rule.providers? && rule.providers[0]?)
					@socialIcon(rule.providers[0])
				else
					'fa fa-exclamation'
			else
				'fa fa-exclamation'
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

	Handlebars.registerHelper 'profileImageOfSize', (player, size) ->
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/#{player}/image' class='img-circle' height='#{size}' width='#{size}'></image>")

	Handlebars.registerHelper 'myImage', () ->
		new Handlebars.SafeString("<image src='http://api.#{window.location.host}/profile/my/image' class='img-circle' height='100' width='100'></image>")

	Handlebars.registerHelper 'privacyRule', (rule) ->
		if (rule == "me")
			new Handlebars.SafeString("<span class='fa fa-user'></span> me")
		else if (rule == "world")
			new Handlebars.SafeString("<span class='fa fa-globe'></span> world")
		else if (rule == "friends")
			new Handlebars.SafeString("<span class='fa fa-users'></span> friends")

	Handlebars.registerHelper 'privacyRuleIcon', (rule) ->
		if (rule == "me")
			new Handlebars.SafeString("<span class='fa fa-user'></span>")
		else if (rule == "world")
			new Handlebars.SafeString("<span class='fa fa-globe'></span>")
		else if (rule == "friends")
			new Handlebars.SafeString("<span class='fa fa-users'></span>")

	Handlebars.registerHelper "timeoutRule", (rule) ->
		if (rule? && rule.timeoutCalculator.type == "eod")
			ruleDay = rule.timeoutCalculator.days
			dayPresentation = if (ruleDay == 1)
				"Daily"
			else if (ruleDay == 7)
				"Weekly"
			else if (ruleDay == 30)
				"Monthly"
			else
				"#{ruleDay} Days"

			punishment = Utils.punishment(rule.punishment)
			new Handlebars.SafeString("#{dayPresentation}<br/> <small>penalty #{punishment}</small>")
		else if (rule.timeoutCalculator.type == "move")
			new Handlebars.SafeString(Utils.humanTime(rule.timeoutCalculator.limit))
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
		icon = Utils.socialIcon(social)
		new Handlebars.SafeString(icon)

	Handlebars.registerHelper "socialShare", () ->
		new Handlebars.SafeString("<div class='pull-rigth'>
			<a share='facebook'><span class='fa fa-2x fa-facebook-square'></span></a>
			<a share='twitter'><span class='fa fa-2x fa-twitter-square'></span></a>
		</div>")

	Handlebars.registerHelper 'template', (t) ->
		template = require "/templates/#{t}"
		rendered = template(this)
		new Handlebars.SafeString(rendered)

	Handlebars.registerHelper 'ruleIcon', (rule) ->
		ruleIcon = Utils.ruleToIcon(rule)
		new Handlebars.SafeString("<span class='#{ruleIcon}'></span>")