html = require "lapis.html"

class AdminCompetitionEdit extends html.Widget
	content: =>
		h1 "Editing '#{@comp.name}'"

		div class: 'content', ->
			div class: 'split-2', ->
				form method: 'POST', ->
					input type: 'hidden', name: 'id', value: "#{@comp.id}", ""

					label for: 'name', 'Competition name'
					input type: 'text', name: 'name', value: "#{@comp.name}", ""

					label for: 'start_time', 'Start time'
					input type: 'datetime-local', name: 'start_time', value: "#{@comp.start}", ""

					label for: 'end_time', 'End time'
					input type: 'datetime-local', name: 'end_time', value: "#{@comp.end}", ""

					input type: 'submit', value: 'Save competition'
				
				div ->
					div class: 'header-line', ->
						span "Problems"

					div class: 'box', ->
						if @comp_problems
							for cp in *@comp_problems
								div class: 'highlight split-lr', ->
									div class: 'tabbed-split tab-32 primary-dark', ->
										span class: 'pad-12', -> text cp.letter
										div class: 'pad-12', -> text "#{cp.name}"

									div class: 'pad-12 button-list', ->
										a href: (@url_for "admin.competition.delete_problem", {}, { competition_id: @comp.id, problem_id: cp.problem_id }), 'Remove'

					h2 class: 'mar-t-32', "Add problem"
					form method: 'POST', action: (@url_for 'admin.competition.add_problem'), ->
						input type: 'hidden', name: 'competition_id', value: "#{@comp.id}", ""

						label for: 'problem_name', 'Problem name'
						element 'select', name: 'problem_name', ->
							for prob in *@all_problems
								option value: "#{prob.short_name}", "#{prob.name}"

						label for: 'letter', 'Problem letter'
						element 'select', name: 'letter', ->
							for i = 0, 25, 1
								letter = string.char (65 + i)
								option value: "#{letter}", "#{letter}"

						input type: 'submit', value: 'Add problem'
