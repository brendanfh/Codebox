html = require 'lapis.html'

class JoinCompetition extends html.Widget
	content: =>
		h1 "Join #{@competition.name}"

		div class: 'content', ->
			div class: 'box pad-12', style: 'font-size: 1.4rem', ->
				p "It looks like you have not joined the competition."
				p "Would you like to join the current competition?"
				p "Your name will appear on the leaderboard and you will be able to see the problems for this competition."

			a href: (@url_for 'join_competition', { competition_name: @competition.short_name }), class: 'button w100 ta-center', 'Join the competition'

