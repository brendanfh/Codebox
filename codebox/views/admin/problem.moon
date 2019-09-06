html = require "lapis.html"

class AdminProblems extends html.Widget
	content: =>
		h1 'Problems'

		div class: 'content', ->
			a class: 'button', href: (@url_for 'admin.problem.new'),
				-> text 'Create a problem'

			br ''
			for problem in *@problems
				div class: 'w50 left pad-12', ->
					div class: 'option-line', ->
						span "#{problem.name}"
						div class: 'button-list', ->
							a href: (@url_for 'admin.problem.edit', problem_name: problem.short_name), 'Edit'
							a { 'data-problem-delete': problem.short_name }, 'Delete'

					div class: 'box', ->
						div class: 'highlight pad-12 split-lr', ->
							span "Id:"
							span "#{problem.id}"
						div class: 'highlight pad-12 split-lr', ->
							span "Short name:"
							span "#{problem.short_name}"
						div class: 'highlight pad-12 split-lr', ->
							span "Time limit:"
							span "#{problem.time_limit}ms"
						div class: 'highlight pad-12 split-lr', ->
							span "Correct submissions:"
							span "#{problem\get_correct_jobs![1].count}"
						div class: 'highlight pad-12 split-lr', ->
							span "Wrong submissions:"
							span "#{problem\get_wrong_answer_jobs![1].count}"
						div class: 'highlight pad-12 split-lr', ->
							span "Timed out submissions:"
							span "#{problem\get_timed_out_jobs![1].count}"
