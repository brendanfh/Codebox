html = require "lapis.html"

class AdminProblems extends html.Widget
	content: =>
		h1 'Problems'

		div class: 'content', ->
			for problem in *@problems
				div class: 'option-line', ->
					span "#{problem.name}, Time Limit: #{problem.time_limit}"
					div class: 'button-list', ->
						a href: (@url_for 'admin.problem.edit', problem_name: problem.short_name), 'Edit'
						a { 'data-problem-delete': problem.short_name }, 'Delete'

			br ''
			a class: 'button', href: (@url_for 'admin.problem.new'),
				-> text 'Create a problem'
