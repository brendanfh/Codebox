import make_controller from require "controllers.controller"
import capture_errors_json, yield_error from require 'lapis.application'
import assert_valid from require "lapis.validate"
import Problems from require 'models'

make_controller
	middleware: { 'logged_in', 'joined_competition', 'competition_started' }
	scripts: { "pie_chart", 'problem_submit' }
	raw_scripts: {
		"https://polyfill.io/v3/polyfill.min.js?features=es6"
		"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
	}

	inject:
		problem_submitter: 'problem'

    get: capture_errors_json =>
		@navbar.selected = 1

		if @params.problem_name
			@problem = Problems\find short_name: @params.problem_name
			unless @problem\get_is_active!
				yield_error 'Problem is not active'

    	render: 'problem.problem'

	post: capture_errors_json =>
		assert_valid @params, {
			{ "problem_name", exists: true }
			{ "answer", exists: true }
		}

		return (@problem_submitter.submit @params.problem_name, @params.answer, "word", @user.id, @competition.id)
