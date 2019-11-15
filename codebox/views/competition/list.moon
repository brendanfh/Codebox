html = require 'lapis.html'
require 'utils.table'

class CompetitionList extends html.Widget
	content: =>
		current_time = os.time()
		h1 "Current Competitions"

		div class: 'content', ->
			for comp in *@competitions
				continue unless current_time <= comp\get_end_time_num!

				div ->
					a class: 'button w100 ta-center', href: (@url_for "leaderboard", { competition_name: comp.short_name }), ->
						text comp.name

		h1 "Past Competitions"

		div class: 'content', ->
			for comp in *@competitions
				continue if current_time <= comp\get_end_time_num!

				a class: 'button w100 ta-center', href: (@url_for "leaderboard", { competition_name: comp.short_name }), ->
					text comp.name
