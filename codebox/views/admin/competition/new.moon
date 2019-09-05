html = require "lapis.html"

class AdminCompetitionNew extends html.Widget
	content: =>
		h1 "Create a competition"

		div class: 'content', ->
			form method: 'POST', ->
				input type: 'hidden', name: 'csrf_token', value: @csrf_token

				label for: 'name', 'Competition name'
				input type: 'text', name: 'name', placeholder: 'Competition name', ""

				label for: 'start_time', 'Start time'
				input type: 'datetime-local', name: 'start_time', ""

				label for: 'end_time', 'End time'
				input type: 'datetime-local', name: 'end_time', ""

				input type: 'submit', value: 'Create competition'

