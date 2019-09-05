import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Problems from require 'models'

make_controller
	middleware: { 'logged_in', 'admin_required' }

	post: capture_errors_json =>
		assert_valid @params, {
			{ 'short_name', exists: true }
		}

		problem = Problems\find short_name: @params.short_name
		unless problem
			yield_error "Problem not found"

		test_cases = problem\get_test_cases!
		if test_cases
			for tc in *test_cases
				tc\delete!

		competition_problems = problem\get_competitions!
		if competition_problems
			for cp in *competition_problems
				cp\delete!

		jobs = problem\get_jobs!
		if jobs
			for job in *jobs
				job\delete!

		problem\delete!

		json: { success: true }



