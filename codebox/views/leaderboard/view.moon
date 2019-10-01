html = require 'lapis.html'
import CompetitionProblems, LeaderboardProblems from require 'models'
Leaderboard = require 'views.ssr.leaderboard'

class LeaderboardView extends html.Widget
    content: =>
        h1 "#{@competition.name} - Leaderboard"

        div class: 'content', ->
			div ->
				div {
					id: 'comp-info'
					style: 'display: none'
					'data-start': @competition\get_start_time_num!
					'data-end': @competition\get_end_time_num!
				}, ''

				h2 id: 'time-left', class: 'ta-center mar-b-48', ''

				div class: 'progressbar mar-b-12', ->
					div class: 'progressbar-labels', ->
						div "#{@competition.start}"
						div "#{@competition.end}"
					div id: 'progress-meter', class: 'progressbar-meter', style: 'width: 0px', ''

			div id: 'leaderboard-container', ->
				widget (Leaderboard @placements, true)
