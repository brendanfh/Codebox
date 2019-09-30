import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, yield_error from require 'lapis.application'
import Competitions, Problems from require 'models'

make_controller
	middleware: { 'logged_in', 'joined_competition' }
	scripts: { 'pie_chart' }

    get: =>
		@navbar.selected = 2

		@problem_ids = @competition\get_problem_ids!
		@problems = [Problems\find id for id in *@problem_ids]

    	render: 'submission.list'
