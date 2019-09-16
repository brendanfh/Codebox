import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, yield_error from require 'lapis.application'
import Competitions, Problems from require 'models'

make_controller
	inject:
		queries: 'queries'

	middleware: { 'logged_in' }
	scripts: { "pie_chart" }

    get: =>
		@navbar.selected = 1

		if @params.problem_name
			@problem = Problems\find short_name: @params.problem_name

    	render: 'problem.problem'
