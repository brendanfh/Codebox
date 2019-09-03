import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Problems, TestCases from require 'models'

TestCaseView = require "views.admin.problem.test_case"

make_controller
	middleware: { 'logged_in', 'admin_required' }

	post: capture_errors_json =>
		assert_valid @params, {
			{ 'test_case_id', exists: true }
		}

		test_case = TestCases\find uuid: @params.test_case_id
		unless test_case
			yield_error "Test case not found"

		test_case\delete!

		json: { 'success': true }
