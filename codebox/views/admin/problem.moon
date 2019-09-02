html = require "lapis.html"

class AdminProblems extends html.Widget
	content: =>
		ul ->
			for problem in *@problems
				li "#{problem.name} - #{problem.kind} - #{problem.time_limit}"

		a href: (@url_for 'admin.problem.new'),
			-> text 'Create a problem'
