import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Problems, TestCases from require 'models'

TestCaseView = require "views.admin.problem.test_case"

make_controller
	inject:
		uuidv4: 'uuidv4'

	middleware: { 'logged_in', 'admin_required' }

	post: capture_errors_json =>
		assert_valid @params, {
			{ 'short_name', exists: true }
		}

		problem = Problems\find short_name: @params.short_name
		unless problem
			yield_error "Problem not found"

		test_case_id = @uuidv4!
		test_html = (TestCaseView -1, test_case_id, '', '')\render_to_string!

		TestCases\create {
			uuid: test_case_id
			problem_id: problem.id
			input: ''
			output: ''
		}

		return json: {
			success: true
			uuid: test_case_id
			html: test_html
		}

