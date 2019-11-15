html = require "lapis.html"

class AdminCompetitionEdit extends html.Widget
	content: =>
		h1 "Editing '#{@comp.name}'"

		div class: 'content', ->
			div class: 'split-2-1', ->
				div ->
					form method: 'POST', ->
						input type: 'hidden', name: 'id', value: "#{@comp.id}", ""

						div class: 'split-3-1', ->
							div class: 'mar-r-24', ->
								label for: 'name', 'Competition name'
								input type: 'text', name: 'name', value: "#{@comp.name}", ""
							div ->
								label for: 'short_name', 'URL name'
								input type: 'text', name: 'short_name', value: "#{@comp.short_name}", ""

						div class: 'split-3', ->
							div class: 'pad-r-6', ->
								label for: 'start_time', 'Start time'
								input type: 'datetime-local', name: 'start_time', value: "#{@comp.start}", ""

							div class: 'pad-l-6 pad-r-6', ->
								label for: 'end_time', 'End time'
								input type: 'datetime-local', name: 'end_time', value: "#{@comp.end}", ""

							div class: 'pad-l-6', ->
								label for: 'time_offset', 'Time offset (in minutes)'
								input type: 'number', name: 'time_offset', value: "#{@comp.time_offset}", ""

						div class: 'mar-t-48', -> text ""

						div class: 'split-3', ->
							div class: 'mar-r-12', ->
								label for: 'programming_points', 'Programming points'
								input type: 'number', name: 'programming_points', value: "#{@comp.programming_points}", ""

							div class: 'mar-r-12 mar-l-12', ->
								label for: 'codegolf_points', 'Code golf points'
								input type: 'number', name: 'codegolf_points', value: "#{@comp.codegolf_points}", ""

							div class: 'mar-l-12', ->
								label for: 'word_points', 'Word points'
								input type: 'number', name: 'word_points', value: "#{@comp.word_points}", ""

						input class: 'mar-t-24', type: 'submit', value: 'Save competition'

					div class: 'header-line mar-t-48', ->
						span "Joined users"

					div class: 'box', ->
						for user in *@comp_users
							div class: 'highlight pad-12 split-lr', ->
								div "#{user.u.username} - #{user.u.nickname}"
								div class: 'button-list', ->
									a href: (@url_for "admin.competition.remove_user", {}, { competition_id: @comp.id, user_id: user.user_id }), 'Remove'

				div class: 'mar-l-24', ->
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
