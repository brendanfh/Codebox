import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Problems from require 'models'

make_controller
	inject:
		queries: 'queries'
        executer: 'executer'

	middleware: { 'logged_in' }
    scripts: { 'vendor/ace/ace', 'problem_submit' }

    get: capture_errors_json =>
        assert_valid @params, {
            { "problem_name", exists: true }
        }

		@navbar.selected = 1

        @problem = Problems\find short_name: @params.problem_name

    	render: 'problem.submit'
    
    post: capture_errors_json =>
        assert_valid @params, {
            { "problem_name", exists: true }
            { "lang", exists: true }
            { "code", exists: true }
        }

        problem = Problems\find short_name: @params.problem_name
        unless problem
            return json: { status: 'problem not found' }
        
        test_cases = problem\get_test_cases!

        id = @executer\request @params.lang, @params.code, @user.id, problem.id, test_cases, problem.time_limit

        json: id

