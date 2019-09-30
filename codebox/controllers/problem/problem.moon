import make_controller from require "controllers.controller"
import capture_errors_json, yield_error from require 'lapis.application'
import Problems from require 'models'

make_controller
	middleware: { 'logged_in', 'joined_competition', 'competition_started' }
	scripts: { "pie_chart" }
	raw_scripts: {
		"https://polyfill.io/v3/polyfill.min.js?features=es6"
		"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
	}

    get: capture_errors_json =>
		@navbar.selected = 1

		if @params.problem_name
			@problem = Problems\find short_name: @params.problem_name
			unless @problem\get_is_active!
				yield_error 'Problem is not active'

    	render: 'problem.problem'

