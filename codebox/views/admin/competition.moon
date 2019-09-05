html = require "lapis.html"

class AdminCompetition extends html.Widget
	content: =>
		h1 'Competitions'

		div class: 'content', ->
			a class: 'button', href: (@url_for 'admin.competition.new'),
				-> text 'Create a competition'

			for comp in *@competitions
				div class: 'header-line', ->
					span comp.name

				div class: 'box', ->
					div class: 'highlight pad-12 split-lr', ->
						span 'Start time'
						span comp.start

					div class: 'highlight pad-12 split-lr', ->
						span 'End time'
						span comp.end


