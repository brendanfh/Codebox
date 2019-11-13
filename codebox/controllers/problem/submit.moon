import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Problems from require 'models'

make_controller
    inject:
		problem: 'problem'

    middleware: { 'logged_in', 'joined_competition', 'during_competition' }
    scripts: { 'vendor/ace/ace', 'problem_submit' }

    get: capture_errors_json =>
        assert_valid @params, {
            { "problem_name", exists: true }
        }

        @navbar.selected = 1

        @problem = Problems\find short_name: @params.problem_name
		if @problem.kind == Problems.kinds.word
			yield_error "Cannot view submit page for word problem"
			return

        render: 'problem.submit'

    post: capture_errors_json =>
        assert_valid @params, {
            { "problem_name", exists: true }
            { "lang", exists: true }
            { "code", exists: true }
        }

		return (@problem.submit @params.problem_name, @params.code, @params.lang, @user.id, @competition.id)
