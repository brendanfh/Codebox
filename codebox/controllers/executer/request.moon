import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors from require 'lapis.application'
import Problems from require 'models'

make_controller
	inject:
		executer: 'executer'

	middleware: { 'internal_request' }

	post: capture_errors (=>
		assert_valid @params, {
			{ 'lang', exists: true }
			{ 'code', exists: true }
			{ 'problem_id', exists: true, is_integer: true }
		}

		problem = Problems\find @params.problem_id
		unless problem
			return json: { status: 'problem not found' }

		test_cases = problem\get_test_cases!

		id = @executer\request @params.lang, @params.code, 1, @params.problem_id, test_cases, problem.time_limit

		json: id
	), =>
		json: { status: 'error occured', errors: @errors }



