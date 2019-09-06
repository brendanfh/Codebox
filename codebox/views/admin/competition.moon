html = require "lapis.html"

class AdminCompetition extends html.Widget
	content: =>
		h1 'Competitions'

		div class: 'content', ->
			a class: 'button', href: (@url_for 'admin.competition.new'),
				-> text 'Create a competition'

			for comp in *@competitions
				div class: 'option-line', ->
					span comp.name
					div class: 'button-list', ->
						a href: (@url_for "admin.competition.activate", { competition_id: comp.id }), "Make active"
						a href: (@url_for "admin.competition.edit", { competition_id: comp.id }), "Edit"
						a href: (@url_for "admin.competition.delete", { competition_id: comp.id}), 'Delete'

				div class: 'box', ->
					if comp.active
						div class: 'highlight pad-12', ->
							span 'Active'

					div class: 'highlight pad-12 split-lr', ->
						span 'Start time'
						span comp.start

					div class: 'highlight pad-12 split-lr', ->
						span 'End time'
						span comp.end
