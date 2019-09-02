html = require "lapis.html"

class AdminProblems extends html.Widget
	content: =>
		h1 "Create a problem"

		div class: 'content', ->
			form method: 'POST', ->
				input type: 'hidden', name: 'csrf_token', value: @csrf_token

				label for: 'name', 'Problem name'
				input type: 'text', name: 'name', placeholder: 'Problem name', ""

				label for: 'name', 'Short name'
				input type: 'text', name: 'short_name', placeholder: 'Short URL name', ""

				label for: 'name', 'Problem description'
				textarea name: 'description', placeholder: 'Problem description', ""

				label for: 'name', 'Time limit'
				input type: 'number', value: 500, name: 'time_limit', ""

				input type: 'submit', value: 'Create problem'

