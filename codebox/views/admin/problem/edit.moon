html = require "lapis.html"

class AdminProblemEdit extends html.Widget
	content: =>
		h1 "Editing '#{@problem.name}'"

		div class: 'content', ->
			form method: 'POST', ->
				input type: 'hidden', name: 'csrf_token', value: @csrf_token
				input type: 'hidden', name: 'problem_id', value: @problem.id

				label for: 'name', 'Problem name'
				input type: 'text', name: 'name', placeholder: 'Problem name', value: @problem.name, ""

				label for: 'name', 'Short name'
				input type: 'text', name: 'short_name', placeholder: 'Short URL name', value: @problem.short_name, ""

				label for: 'name', 'Problem description'
				textarea name: 'description', placeholder: 'Problem description', @problem.description

				label for: 'name', 'Time limit'
				input type: 'number', value: 500, name: 'time_limit', value: @problem.time_limit, ""

				input type: 'submit', value: 'Update problem'
