html = require "lapis.html"

class AdminProblems extends html.Widget
	content: =>
		h1 'Problems'

		div class: 'content', ->
			a class: 'button', href: (@url_for 'admin.problem.new'),
				-> text 'Create a new problem'

			div class: 'bcolor-pd pad-12 split-6', ->
				span "Id"
				span "Problem name"
				span "Short name"
				span "Time limit"
				span "C / W / TO"
				span "Options"

			div class: 'box', ->
				for problem in *@problems
					div class: 'highlight pad-12 split-6', ->
						span "#{problem.id}"
						span "#{problem.name}"
						span "#{problem.short_name}"
						span "#{problem.time_limit}ms"
						span "#{problem\get_correct_jobs!} / #{problem\get_wrong_answer_jobs!} / #{problem\get_timed_out_jobs!}"
						div class: 'button-list', ->
							a href: (@url_for 'admin.problem.edit', problem_name: problem.short_name), 'Edit'
							a { 'data-problem-delete': problem.short_name }, 'Delete'

