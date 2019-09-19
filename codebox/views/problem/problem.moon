html = require "lapis.html"
markdown = require "markdown"

class Problems extends html.Widget
	content: =>
		raw '<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
			<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>'

		div class: 'sidebar-page-container', ->
			div class: 'sidebar-problem-list', ->
				widget (require 'views.partials.problem_sidebar')

			div class: 'content', ->
				unless @problem
					h1 "Select a problem from the sidebar"
				else
					h1 @problem.name
					div class: 'problem-info mar-l-24 mar-b-24', ->
						a style: "text-align: center; margin-bottom: 0", class: 'button w100', href: (@url_for 'problem.submit', { problem_name: @problem.short_name }), ->
							text "Make a submission"

						div class: 'box split-lr pad-12', ->
							div "Time limit:"
							div "#{@problem.time_limit}ms"

						div style: 'font-size: 1.3rem;', class: 'header-line', -> text "Stats for #{@problem.name}"

						correct = @problem\get_correct_jobs!
						wrong = @problem\get_wrong_answer_jobs!
						timed_out = @problem\get_timed_out_jobs!
						error = @problem\get_error_jobs!

						div class: 'box', ->
							if (correct + wrong + timed_out + error) > 0
								piechart {
									style: 'display: inline-block; text-align: center; width: 100%'
									class: "pad-12"
									"data-segments": 4,
									"data-segment-1": correct,
									"data-segment-1-color": "#44ff44",
									"data-segment-2": wrong,
									"data-segment-2-color": "#ff4444",
									"data-segment-3": timed_out,
									"data-segment-3-color": "#4444ff",
									"data-segment-4": error,
									"data-segment-4-color": "#777777"
								}, ""

							div class: 'pad-8 split-lr', ->
								p style: "color: #44ff44", -> text "Correct"
								p "#{correct}"
							div class: 'pad-8 split-lr', ->
								p style: "color: #ff4444", -> text "Wrong answer"
								p "#{wrong}"
							div class: 'pad-8 split-lr', ->
								p style: "color: #4444ff", -> text "Timed out"
								p "#{timed_out}"
							div class: 'pad-8 split-lr', ->
								p style: "color: #777777", -> text "Other error"
								p "#{error}"

					div class: 'problem-description', ->
						raw (markdown @problem.description)
